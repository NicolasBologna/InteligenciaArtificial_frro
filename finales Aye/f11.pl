%vehiculo(cod_vehiculo,[color,aire_acondicionado,puertas,modelo]).
%ventas(num_factura,cod_vehiculo,fecha).

:-dynamic(vehiculo/2).
:-dynamic(ventas/3).

inicio:-abrirDb,writeln('Ingrese opcion'),
                writeln('1. Listado de autos para una característica dada'),
                writeln('2. Listado de autos que se hayan vendido más de 10 veces en un año'),
                writeln('3. Salir'),read(Op),opcion(Op).

opcion(1):-writeln('Ingrese una característica: '),read(Car),buscarAutos(Car,Lista),
           writeln('Listado de autos con dicha característica: '),write(Lista),nl,inicio.

opcion(2):-writeln('Ingrese listado de códigos de autos: '),leer(List_ve),
           writeln('Ingrese año: '),read(Anio),buscarAutos2(List_ve,Anio,Lista),
           writeln('Listado de autos que se vendieron mas de 10 veces ese año: '),write(Lista),nl,inicio.

opcion(3):-writeln('Bye Bye').


%Generales.
abrirDb:-retractall(vehiculo/2),retractall(ventas/3),
         consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f11.txt').

pertenece([H|_],H).
pertenece([_|T],H):-pertenece(T,H).

leer([H|T]):-read(H),H\=[],leer(T).
leer([]).

%Opcion 1.
buscarAutos(Car,[Cod_ve|T]):-retract(vehiculo(Cod_ve,List_car)),pertenece(List_car,Car),buscarAutos(Car,T).
buscarAutos(_,[]).

%Opcion 2.
buscarAutos2([Cod_ve|T1],Anio,[Cod_ve|T2]):-contarVentas(Cod_ve,Anio,Cant),Cant > 10,buscarAutos2(T1,Anio,T2).
buscarAutos2([_|T1],Anio,Lista):-buscarAutos2(T1,Anio,Lista).
buscarAutos2([],_,[]).


contarVentas(Cod_ve,Anio,Cant):-retract(ventas(_,Cod_ve,Fecha)),sub_atom(Fecha,_,4,0,Anio_string),
                               atom_number(Anio_string,Anio),contarVentas(Cod_ve,Anio,Cant_ant),
                               Cant is Cant_ant + 1.
contarVentas(_,_,0).

