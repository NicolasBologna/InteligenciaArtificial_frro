/*Los ... son datos que no eran relevantes para el desarrollo del ejercicio):

catedra(nombre_catedra,...).
comision(nombre_catedra,comision,ciclo,...,[legajos de inscriptos]).
alumno(legajo,nombre,...).

* Aclaracion: una catedra puede tener muchas comisiones *

Te pedia:
1- Devolver lista [] de las catedras del ciclo 2017 que tengan más de 100 inscriptos en sus comisiones.
2- Mostrar las catedras en las que se encuentra inscripto un alumno
(ingresando el legajo) tambien en el ciclo 2017.*/



inicio:-
    abrirBase, writeln('1-Catedras con mas de 100 inscriptos en este ciclo 2-Catedras por alumno en este ciclo 3-Salir. Ingrese opción: '),
    read(O),
    menu(O).

:- dynamic(catedra/2).
:- dynamic(comision/4).
:- dynamic(alumno/2).

abrirBase:- retractall(catedra/2), retractall(comision/2),consult('D:/Documentos/Prolog/Finales/IA_Final_Practica_2017-09.txt').

menu(1):-
    getCatedrasPopulosas(Catedras),listar(Catedras).
menu(2):-
    write('Ingrese legajo: '),
    read(L),
    catedras_alumno(L, Catedras),
    listar(Catedras).
menu(3).
menu(_):-
    writeln('Opcion incorrecta.'), inicio.

getCatedrasPopulosas([Cat|T]):-
    retract(catedra(Cat,_)),
    sumaComisionesCatedra(Cat,Total),
    Total >= 10,
    getCatedrasPopulosas(T).
getCatedrasPopulosas([]).
getCatedrasPopulosas(_).

sumaComisionesCatedra(Cat,Total):-
    retract(comision(Cat,_,2017,Leg)),
    contar(Leg,Cant),
    sumaComisionesCatedra(Cat,Ac),
    Total is Ac+Cant.

sumaComisionesCatedra(_,0).

contar([],0).
contar([_|T],Cant):-
    contar(T,CantCola),
    Cant is CantCola + 1.

catedras_alumno(L, [Cat|T]):-
    alumno(L,_),
    retract(catedra(Cat,_)),
    retract(comision(Cat,_,2017,Legs)),
    pertenece(L, Legs),
    %agregar(Cat,Catedras,Lista),
    catedras_alumno(L, T).
catedras_alumno(_,[]).

pertenece(X,[X|_]).
pertenece(X,[_|T]):- pertenece(X,T).

listar([H|T]):- writeln(H), listar(T).
listar([]).







