%jardin(cod_jardin, nombre_jardin, 1[tipo_sala]n).
%salas(cod_jardin, nombre_sala, tipo_sala, 1[dni_asistente]n).

:-dynamic (jardin/3).
:-dynamic (salas/4).

%Generales.
abrirDb:-retractall(jardin/3),retractall(salas/4),
         consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f9.txt').

leer([H|T]):-read(H), H\=[], leer(T).
leer([]).

pertenece([H|_],H).
pertenece([_|T],H):-pertenece(T,H).

%Menu.
inicio:-abrirDb, writeln('Ingrese opcion: '),
                 writeln('1. Listado de alumnos asistentes a un jardin'),
                 writeln('2. Listado de jardines con los tipos de salas indicados'),
                 writeln('3. Salir'), read(Op), opcion(Op).

opcion(3):-writeln('Bye Bye').

opcion(1):-writeln('Ingrese lista de dnis de alumnos'), leer(List_dni), writeln('Ingrese código de jardin'), read(Cod_jardin),
           determinarAsistentes(List_dni,Cod_jardin,Lista), write('Los alumnos que asisten al jardin indicado son: '),
           writeln(Lista), nl, inicio.

opcion(2):-writeln('Ingrese lista de códigos de jardines'), leer(List_jardin),
           writeln('Ingrese lista de tipos de salas'), leer(List_salas),
           determinarJardines(List_jardin,List_salas,Lista), write('Los jardines que tienen todos los tipos de salas son: '),
           writeln(Lista), nl, inicio.

%Opcion 1.
determinarAsistentes([Dni|T1],Cod_jardin,[Dni|T2]):-salas(Cod_jardin,_,_,List_asist), pertenece(List_asist, Dni),
                                                    determinarAsistentes(T1,Cod_jardin,T2).
determinarAsistentes([_|T1],Cod_jardin,Lista):-determinarAsistentes(T1,Cod_jardin,Lista).
determinarAsistentes([],_,[]).

%Opcion2.
determinarJardines([Cod_jardin|T1],List_salas,[Cod_jardin|T2]):-jardin(Cod_jardin,_,List_salas_jardin),
                                                                compararSalas(List_salas,List_salas_jardin),
                                                                determinarJardines(T1,List_salas,T2).
determinarJardines([_|T1],List_salas,Lista):-determinarJardines(T1,List_salas,Lista).
determinarJardines([],_,[]).

compararSalas([Tipo_sala|T1],List_jardin):-pertenece(List_jardin,Tipo_sala),compararSalas(T1,List_jardin).
compararSalas([],_).
