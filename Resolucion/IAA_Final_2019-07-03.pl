% 1)Ingresar una caracteristica y devolver una lista con códigos de los autos que tengan esa caracteristica.
% 2)Ingresar una lista de código de vehiculos y un año y devolver una lista con los
% autos que se hayan vendido mas de 10 veces en ese año.

% vehiculo(cod_vehiculo, [caracteristicas]).
%                         caracteristicas: [color, aire acondicionado, puertas, modelo]
% ventas(num_factura, cod_vehiculo, fecha).

:-dynamic(vehiculo/2).
:-dynamic(ventas/3).
:-dynamic(vent/2).


inicio :- writeln("1 - (Listar autos que posean la caracteristica ingresada)"),
          writeln("2 - (Consultar autos que se vendieron mas de 10 veces en el año buscado)"),
          writeln("3 - (Salir)"), read(Opc), Opc \= 3, opcion(Opc).

inicio :- write("Que tenga buen dia").

opcion(1) :- abrir_base, writeln("Ingrese una caracteristica: "), read(C), consultaCaracteristica(C, Lista),
             mostrarListado(Lista), inicio.

opcion(2) :- writeln("Ingrese año de busqueda: "), read(A),
             writeln("Ingrese listado de vehiculos a comprobar: "), leer(L),
             consultaVehiculo(A, L, LSalida), mostrarListado(LSalida), inicio.

consultaCaracteristica(C, [H|T]) :- retract(vehiculo(H, Caracteristicas)), pertenece(C, Caracteristicas), consultaCaracteristica(C,T).
%consultaCaracteristica(C, [_|T]) :- consultaCaracteristica(C, T).   ojo se usa cuando hay 2 listados nomas
consultaCaracteristica(_, []).

pertenece(H, [H|_]).
pertenece(H, [_|T]) :- pertenece(H, T).

mostrarListado([H|T]) :- write(" - Codigo: "), writeln(H), mostrarListado(T).
mostrarListado([]).



consultaVehiculo(A, [H|T1], [H|T2]) :- retractall(vent/2), getVent, consultaVentas(A, H, Cant), Cant > 10, consultaVehiculo(A, T1, T2).
consultaVehiculo(A, [_|T1], S) :- consultaVehiculo(A, T1, S).
consultaVehiculo(_, [], []).

consultaVentas(A, H, Cant) :-  vent(H, A), retract(vent(H, A)), consultaVentas(A, H, Cant2), Cant is Cant2 + 1.
consultaVentas(_, _, 0).

getVent :- ventas(_, H, A), assert(vent(H, A)), fail.
getVent.

leer([H|T]) :- writeln("Ingrese codigo de vehiculo o [] para terminar"), read(H), H \= [], leer(T).
leer([]).

abrir_base :- retractall(vehiculo/2), retractall(ventas/3), consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_Final_2019-07-03.txt').