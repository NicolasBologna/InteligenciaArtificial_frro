/*
 * Dada la siguiente BD:
persona(dni,nombre,edad).
auto_vendido(patente,codModelo,fecha,precio,[DNItitulares])
auto(codModelo,modelo)
1) ingresar dni de una persona y mostrar todos los autos de los que es titular.
2) ingresar el codigo de un auto y calcular el precio promedio de autos vendidos.
3) mostrar el titular mas joven de cada auto vendido.
TEORIA: también la tomo juan moine.
Te daba un tema y te dejaba que te escribas en una hoja las ideas principales. Después se las tenias que comentar oral. Si estabas flojo te tomaba otro tema mas.
temas de teoria que tomo:
-algoritmos genéticos.
-busqueda a ciegas
-busqueda heuristica
-redes neuronales.
-sistema experto.
 *
 */
:- dynamic(auto_vendido/5).

inicio:-
    writeln('1- Mostrar autos de una persona'),
    writeln('2- Calcular precio promedio de venta de un auto'),
    writeln('3- Mostrar titulares mas jovenes'),
    write('Ingrese opcion: '),
    read(O),
    menu(O).

abrirBase:-
    retractall(auto_vendido/5),
    consult('D:/Documentos/Prolog/Finales/IA_Final_Practica_2014-09-25.txt').

menu(1):-
    abrirBase,
    write('Ingrese DNI: '),
    read(DNI),
    getAutos(DNI,Autos),
    mostrar(Autos).

menu(2):-
    abrirBase,
    write('Ingrese un codigo de auto: '),
    read(Cod),
    auto(Cod,_),
    getPrecioPromedio(Cod,Acum,Cant),
    write('El precio promedio es: $'),
    Prom is Acum/Cant,
    write(Prom).
menu(2):-
    write('Codigo incorrecto.').

menu(3):-
    abrirBase,
    getJovenes.


getAutos(DNI,[Pat|T]):-
    retract(auto_vendido(Pat,_,_,_,Titulares)),
    pertenece(DNI,Titulares),
    getAutos(DNI,T).
getAutos(_,[]).

getPrecioPromedio(Cod,Acum,Cant):-
    retract(auto_vendido(_,Cod,_,P,_)),
    getPrecioPromedio(Cod,AuxAcum,AuxCant),
    Acum is AuxAcum+P,
    Cant is AuxCant+1.
getPrecioPromedio(_,0,0).

getJovenes:-
    retract(auto_vendido(Pat,_,_,_,Titulares)),
    getMenor(Titulares,DNI),
    write('El menor del auto '),write(Pat),write(' es '),write(DNI),nl,
    getJovenes.
getJovenes.

getMenor([DNI|T],Menor):-
    persona(DNI,_,Edad),


pertenece(X,[X|_]).
pertenece(X,[_|T]):- pertenece(X,T).

mostrar([H|T]):- writeln(H),mostrar(T).
mostrar([]).
