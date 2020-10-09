/*
 Hechos:
 jardin(CodigoJ, [Tipos de Sala]) 
 salas(CodigoJ, tipo_de_sala, [Dni Asistentes])
 1 - Dada una Lista [] de Dni, y un Codigo de Jardin Devolver una Lista [] con aquellos Dni que asisten realmente al Jardin.

 2 - Dada una Lista [] de Jardines, y una Lista [] de Tipos de Sala, devolver una Lista [] con los Jardines que tengan todos los tipos de sala.

 Tips: en ninguno se usaba (o era necesario retract), como solo es recorrer listas las condiciones de fin van al principio. 
 De los que andan dando vuelta, no había visto uno con esta complejidad, no es imposible, pero hay que pensarlo, si el resto los aprendiste mecánicos este costaba un poco más. */

:-dynamic(jardin/2).
:-dynamic(salas/3).

menu :- writeln("1 - (Listar DNIs de aquellos que asistan al jardin)"),
        writeln("2 - (Listar los jardines que tenga todos los tipos de sala ingresados)"),
        writeln("3 - (Salir)"), read(Opc), Opc \= 3, abrir_base, opcion(Opc), menu.
menu :- writeln("Que tenga un buen dia").

opcion(1) :- writeln("Ing. la lista de jardines"), leer(LJ), writeln("Ing. la lista de DNIs"), leer(LD),
             buscaP(LJ, LD, S), write("Estos DNIs estan asistiendo en algun jardin de los ingresados: "), writeln(S).

opcion(2) :- writeln("Ingrese lista de Jardines"), leer(LJ), writeln("Ing. el listado de tipos de Salas"), leer(TSs),
             buscaP2(LJ,TSs,S), write("Los jardines que tienen todas estas salas son: "), writeln(S).

buscaP2([H|T], TS, [H|T2]) :- jardin(H, Salas), contenido(TS, Salas), buscaP2(T, TS, T2).
buscaP2([_|T], TS, T2) :- buscaP2(T, TS, T2).
buscaP2([], _, []).

contenido([H|T], Salas) :- pertenece(H,Salas), contenido(T,Salas).
contenido([],_).

leer([H|T]) :- writeln("Ingrese Codigo o [] para terminar"), read(H), H \= [], leer(T).
leer([]).

buscaP([H|T], ListD, S) :- salas(H, _, DA), buscaS(ListD, DA, S2), buscaP(T, ListD, S3), concatena(S2, S3, S).
buscaP([], _, []).

buscaS([H|T], DA, [H|T2]) :- pertenece(H, DA), buscaS(T, DA, T2).
buscaS([_|T], DA, T2) :- buscaS(T, DA, T2).
buscaS([], _, []).

pertenece(H, [H|_]).
pertenece(H, [_|T]) :- pertenece(H, T).

concatena([H|T], L2, [H|T2]) :- concatena(T, L2, T2).
concatena([], [H|T], [H|T2]) :- concatena([], T, T2).
concatena([], [], []).

abrir_base :- retractall(jardin/2), retractall(salas/3), 
              consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_Final_2017-11-16.txt').