/*
 * Base de hechos
vehículo (Cod,...,[Características]).
características puede ser A/C, levanta vidrios,etc
ventas(CodVeh, Fecha....).
Fecha tiene formato dd/mm/aaaa
1)Ingresar una característica y devolver una lista [] con los códigos de todos los autos que tengan esa característica.
2)Ingresar una lista [] de códigos de auto y un Año y armar una nueva lista [] con los códigos de esos autos, que tengan más de 10 ventas.
*
*/
:- dynamic(vehiculo/2).
:- dynamic(ventas/2).

inicio:-
    write('1- Ver autos con una caracteristica 2- Ver autos con mas de 10 ventas 3- Salir. Ingrese opcion: '),
    read(O),
    menu(O).

abrirBase:- retractall(vehiculo/2), retractall(venta/2),consult('D:/Documentos/Prolog/Finales/IA_Parcial_Promocion_2017_Base.txt').

menu(1):-
    abrirBase,
    writeln('Ingrese caracteristica: '),
    read(C),
    getAutos(C,Lista),
    mostrar(Lista).

menu(2):-
    abrirBase,
    write('Ingrese lista de codigos: '),
    leerLista(Lista),
    write('Ingrese un año: '),
    read(A),
    filtrar(Lista, F, A),
    writeln(F).

getAutos(C,[Cod|T]):-
    retract(vehiculo(Cod,Carac)),
    pertenece(C,Carac),
    getAutos(C,T).
getAutos(_,[]).
getAutos(_,_).

filtrar([H1|T1],[H1|T2], A):-
    contarVentas(H1,Cant,A),
    Cant > 2,
    filtrar(T1,T2,A).
filtrar([_|T],F,A):-filtrar(T,F,A).
filtrar([],[],_).

contarVentas(Cod,Cant,A):-
    retract(ventas(Cod,Fecha)),
    sub_atom(Fecha,_,4,0,A),
    contarVentas(Cod,Acum,A),
    Cant is Acum+1.
contarVentas(_,0,_).

leerLista([H|T]):-
    read(H),
    H\=[],
    leerLista(T).
leerLista([]).

mostrar([H|T]):- writeln(H), mostrar(T).
mostrar([]).

pertenece(X,[X|_]).
pertenece(X,[_|T]):- pertenece(X,T).
