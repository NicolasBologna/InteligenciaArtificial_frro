%colegio(Cod_colegio,Direccion,Telefono,Ciudad,1[nivel]n).
%niveles(Cod_colegio,Nivel,Curso,Turno,1[DniAlumnos]n).

:-dynamic (colegio/5).
:-dynamic (niveles/5).

%Menu.
inicio:-abrirDb, writeln('Ingrese opcion'),
                 writeln('1. Colegios rosarinos que ofrezcan el nivel ingresado y que tengan mas de 4 alumnos'),
                 writeln('2. Alumnos que pertenecen a un Colegio y un Turno'),
                 writeln('3. Salir'), read(Op), opcion(Op).

opcion(1):-writeln('Ingrese nivel: '), read(Niv),buscarColegios(Niv,Lista),
           writeln('Los colegios rosarinos que ofrecen ese nivel son: '), write(Lista), nl, inicio.
opcion(2):-writeln('Ingrese colegio: '), read(Col), writeln('Ingrese turno: '), read(Tur),
           writeln('Ingrese listado con Dnis de Alumnos: '), leer(List_alum), filtrarAlumnos(List_alum, Col, Tur, Lista),
           writeln('Los alumnos que realmente pertenecen a ese colegio y turno son: '), write(Lista), nl, inicio.
opcion(3):-writeln('Bye Bye').


%Generales.
abrirDb:-retractall(colegio/5),retractall(niveles/5),
         consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f7.txt').

leer([H|T]):-read(H), H\=[], leer(T).
leer([]).

pertenece([H|_],H).
pertenece([_|T],H):-pertenece(T,H).

contar([_|T],Cant):-contar(T,Cant_ant),Cant is Cant_ant + 1.
contar([],0).

%Opcion 1.
buscarColegios(Niv,[Col|T]):-retract(colegio(Col,_,_,'Rosario',_)), buscarNiveles(Niv,Col,Cant_nivel), Cant_nivel >= 4,
                             buscarColegios(Niv,T).
buscarColegios(_,[]).


buscarNiveles(Niv,Col,Cant_nivel):-retract(niveles(Col,Niv,_,_,List_alum)),contar(List_alum,Cant_alum),buscarNiveles(Niv,Col,Cant_alum_ant),
                                   Cant_nivel is Cant_alum_ant + Cant_alum.
buscarNiveles(_,_,0).


%Opcion 2.
filtrarAlumnos([Al|T1], Col, Tur, [Al|T2]):-niveles(Col,_,_,Tur,List_alum),pertenece(List_alum,Al),
                                            filtrarAlumnos(T1,Col,Tur,T2).
filtrarAlumnos([_|T1],Col, Tur, Lista):- filtrarAlumnos(T1, Col, Tur, Lista).
filtrarAlumnos([],_,_,[]).
