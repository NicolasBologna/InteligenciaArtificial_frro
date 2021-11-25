%persona(Nombre, Edad, 1[Profesion]n, Ciudad).
%curso(Profesion, 1[Curso]n).
%persona_curso(Nombre, Profesion, 1[CursoRealizado]n).

:- dynamic (persona/4).
:- dynamic (curso/2).
:- dynamic (persona_curso/3).


%Generales
abrirBD:-retractall(persona/4), retractall(curso/2), retractall(persona_curso/3),
        consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f5.txt').

pertenece([H|_],H).
pertenece([_|T],H):- pertenece(T,H).

contar([_|T],Cant):-contar(T,Cant_ant), Cant is Cant_ant + 1.
contar([],0).


%Menu
inicio:-abrirBD, writeln('Ingrese opcion '),
                 writeln('1. Edad promedio para una profesión en Rosario'),
                 writeln('2. Lista de cursos faltantes por persona según una profesion'),
                 writeln('3. Profesión con mayor cantidad de cursos '),
                 writeln('4. Salir'), read(Op), opcion(Op).

opcion(1):-writeln('Ingrese profesion: '), read(Prof), calcEdadProm(Prof,Sum,Cant), Cant \= 0, EdadProm is Sum / Cant,
           writeln('La edad promedio de dicha profesion es: '), writeln(EdadProm) , nl, inicio.
opcion(1):-writeln('No hay usuarios registrados para dicha profesión'),nl, inicio.

opcion(2):-writeln('Ingrese profesión: '), read(Prof), curso(Prof,List_Cursos), cursosFaltantes(Prof,List_Cursos), nl, inicio.

opcion(3):-writeln('Profesion con mayor cantidad de cursos: '), masCursos(0,_),nl, inicio.

opcion(4):-writeln('Bye Bye').


%Opcion 1
calcEdadProm(Prof,Sum,Cant):-retract(persona(_,Edad,List_Prof,'rosario')), pertenece(List_Prof,Prof),
                             calcEdadProm(Prof,Sum_ant,Cant_ant), Sum is Sum_ant + Edad, Cant is Cant_ant + 1.
calcEdadProm(_,0,0).

%Opcion 2
cursosFaltantes(Prof,List_Cursos):-retract(persona(Nombre,_,List_Prof,_)), pertenece(List_Prof, Prof),
                                   persona_curso(Nombre,Prof,List_Realizados), comparaCursos(List_Cursos,List_Realizados,Lista),
                                   write('Cursos faltantes del profesional: '), write(Nombre), write(' --- '),
                                   writeln(Lista), cursosFaltantes(Prof,List_Cursos).
cursosFaltantes(_,_).

comparaCursos([Curso|T1],List_Realizados,[Curso|T2]):- not(pertenece(List_Realizados, Curso)),
                                                       comparaCursos(T1,List_Realizados,T2).
comparaCursos([_|T1],List_Realizados,Lista):- comparaCursos(T1,List_Realizados,Lista).
comparaCursos([],_,[]).

%Opcion 3
masCursos(Cant_Act,_):-retract(curso(Prof,List_Cursos)), contar(List_Cursos,Cant),
                          Cant > Cant_Act, masCursos(Cant,Prof).
masCursos(_,Prof):-write(Prof).
