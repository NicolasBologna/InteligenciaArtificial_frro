/*
 * Si no recuerdo mal fue de una remisería. Era algo así:
auto(nro_movil, patente, un par de cosas mas)
viaje(nro_movil, costo)
Y te pedían:
1. Monto total acumulado por cada auto
2. Dada una lista de autos devolver de esa lista cuales tenian al menos un viaje con costo mayor a 300
 *
 */

:-dynamic(auto/2).
:-dynamic(viaje/2).

abrirBase:-
    retractall(auto/2),
    retractall(viaje/2),
    consult('D:/Documentos/Prolog/Finales/IA_Final_Practica_2017-11-30.txt').


inicio:-
    abrirBase,
    write('Op:'),
    read(O),
    menu(O).

menu(1):-
    retract(auto(Nro,Pat)),
    getMonto(Nro,Monto),
    write(Pat),write(' $'),write(Monto),nl,
    menu(1).
menu(1).

menu(2):-
    abrirBase,
    write('Ingrese lista: '),
    leer(Lista),
    getViajesCaros(Lista).

getMonto(Nro,Monto):-
    retract(viaje(Nro,Costo)),
    getMonto(Nro,Acum),
    Monto is Acum+Costo.
getMonto(_,0).

leer([H|T]):- read(H), H\=[],leer(T).
leer([]).

getViajesCaros([H|T]):-
    retract(viaje(H,C)),
    C>300,
    writeln(H),
    getViajesCaros(T).
getViajesCaros([_|T]):-getViajesCaros(T).
getViajesCaros(_).

