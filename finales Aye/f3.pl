%provincia(id_provincia, nombre_provincia).
%localidad(id_localidad, nombre_localidad, id_provincia).
%persona(dni_persona,nombre_persona,fecha_nac,salario,id_localidad).
%candidato(id_candidato, nombre_candidato).
%intencion_de_voto(dni_persona,id_candidato).
%formato para la fecha = dd/mm/aaaa

:-dynamic(provincia/2).
:-dynamic(localidad/3).
:-dynamic(persona/5).
:-dynamic(candidato/2).
:-dynamic(intencion_de_voto/2).

abrirDb:-retractall(provincia/2),retractall(localidad/3),retractall(persona/5),retractall(candidato/2),retractall(intencion_de_voto/2),
         consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f3.txt').

inicio:-abrirDb,writeln('Ingrese opción: '),
                writeln('1. Listar personas nacidas antes de 1950 para una provincia'),
                writeln('2. Salario promedio de las personas con intencion de voto hacia un candidato en una provincia'),
                writeln('3. Salir'),read(Op),opcion(Op).

opcion(1):-writeln('Ingrese provincia: '), read(Nom_Prov),provincia(Id_prov,Nom_Prov),buscarLocalidades(Id_prov,Lista_loc),
           writeln('Las siguientes personas nacieron antes de 1950: '),buscarPersonas(Lista_loc),nl,inicio.
opcion(1):-writeln('No hay datos'),nl, inicio.
opcion(2):-writeln('Ingrese provincia: '), read(Nom_Prov),provincia(Id_prov,Nom_Prov),writeln('Ingrese candidato: '),
           read(Nom_Cand),candidato(Id_cand,Nom_Cand), buscarVotantes(Id_prov,Id_cand,Tot,Cant),Prom is Tot/Cant,
           writeln('El salario promedio de sus votantes en la provincia es: '),write(Prom), nl, inicio.
opcion(2):-writeln('No hay datos'), nl, inicio.
opcion(3):-writeln('Bye Bye').


%Opcion 1
buscarLocalidades(Id_prov,[Id_localidad|T]):-retract(localidad(Id_localidad,_,Id_prov)),buscarLocalidades(Id_prov,T).
buscarLocalidades(_,[]).

buscarPersonas([Id_localidad|T]):-buscarEnLocalidad(Id_localidad),buscarPersonas(T).
buscarPersonas([]).


buscarEnLocalidad(Id_localidad):-retract(persona(Dni,Nombre,Fecha_nac,_,Id_localidad)),sub_atom(Fecha_nac,_,4,0,Anio),atom_number(Anio,Anio_num),
                                 Anio_num < 1950,write('Dni: '),write(Dni),write(' - '),write('Nombre: '),writeln(Nombre),
                                 buscarEnLocalidad(Id_localidad).
buscarEnLocalidad(_).

%Opcion 2
buscarVotantes(Id_prov,Id_cand,Tot,Cant):-retract(intencion_de_voto(Dni,Id_cand)),persona(Dni,_,_,Salario,Id_localidad),
                                          localidad(Id_localidad,_,Id_prov),buscarVotantes(Id_prov,Id_cand,Tot_ant,Cant_ant),
                                          Tot is Tot_ant + Salario, Cant is Cant_ant + 1.
buscarVotantes(_,_,0,0).





