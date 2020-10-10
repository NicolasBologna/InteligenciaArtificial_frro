/* [IA- Inteligencia Artificial] Final mesa especial 18/06/2019

colegio(cod_colegio,direccion,telefono,ciudad,[niveles]).

Niveles podían ser unos 4 o 5 que listaba (este dato no servía)

niveles(cod_colegio,nivel,curso,turno,[dni_Alumnos]).

No tengo las consignas literales, pero eran más o menos las siguientes:

1) Para un nivel ingresado devolver un listado con todos los colegios que sean de Rosario, que ofrezcan el nivel ingresado y que tengan hasta 90 alumnos.

2) Dado un listado de Dni de alumnos ingresado, un Colegio y un Turno, devolver otro listado de los alumnos que verdaderamente pertenezcan a ese colegio y asistan a ese turno (de la lista de ingresada). */

:-dynamic(colegio/5).
:-dynamic(niveles/5).
:-dynamic(colaux/2).

abrir_base :- retractall(colegio/5), retractall(niveles/5), retractall(colaux/2), consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_Final_2019-06-19.txt').

menu:- writeln("1 - (Dado un nivel devolver lisatdo de colegios Rosarinos con cupo < 90)"),
       writeln("2 - (Dado un listado de Alum, un Colegio y Turno listar quienes van a ese Colegio)"),
       writeln("3 - (Salir)"), read(Opc), Opc \= 3, opcion(Opc), menu.
menu:- writeln("Que tenga un buen dia!").

opcion(1) :- abrir_base, writeln("Ingrese un nivel"), read(N), retractall(colaux/2), getCol(N), devLista(Lista), write("Salida: "), writeln(Lista).

opcion(2) :- abrir_base, writeln("Ingrese lista de DNIs"), leer(LD),
             writeln("Ingrese un cod de colegio: "), read(Cod),
             writeln("Ing un turno: "), read(Turno), consulta(Cod, Turno, LD, S), writeln(S).

consulta(Cod, Turno, [H|T], [H|T2]) :- niveles(Cod, _, _, Turno, ListDNI), pertenece(H, ListDNI), consulta(Cod, Turno, T, T2).
consulta(Cod, Turno, [_|T], T2) :- consulta(Cod, Turno, T, T2).
consulta(_, _, [], []).

pertenece(X, [X|_]).
pertenece(X, [_|T]) :- pertenece(X, T).

getCol(N) :- retractall(colaux/2), retract(colegio(Cod, _, _, rosario, _)), retract(niveles(Cod, N, _, _, LD)), assert(colaux(Cod, LD)), fail.
getCol(_).

cuenta([_], 1).
cuenta([_|T], Cont) :- T \= [], cuenta(T, ContAux), Cont is ContAux + 1.

devLista([H|T]) :- retract(colaux(H, LD)), cuenta(LD, Cant), Cant < 90, devLista(T).
devLista([]).

leer([H|T]) :- writeln("Ingrese DNI o [] para terminar"), read(H), H \= [], leer(T).
leer([]).