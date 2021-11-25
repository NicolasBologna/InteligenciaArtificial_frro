/*
 * Practica:
1-Ingresar una lista de cadenas y un carácter. Por cada cadena de la lista y el carácter, verificar si ya están en la BD, sino esta registrarlo palabra(cadena,carácter,cantidad).
2-Ingresar un carácter y calcular el promedio de veces que aparece en la BD.
 *
 */

:- dynamic (palabra/3).

inicio:-
    write('Ingrese 1 para ingresar cadena y caracter, 2 para calcular promedio de un caracter: '),
    read(O),
    menu(O).

abrirBase:-
    retractall(palabra/3),
    consult('D://Documentos//Prolog//Finales//IA_Final_Practica_Caracteres.txt').

menu(1):-
    leerPalabras,
    inicio.

leerPalabras:-
    abrirBase,
    write('Ingrese lista de palabras, finalice con []: '),
    leer(Cad),
    write('Ingrese caracter: '),
    read(Car),
    guardar(Cad,Car).

leer([H|T]):- read(H), atom(H), H\=[], leer(T).
leer([]).

guardar([H|T],Car):-
    retract(palabra(H,Car,Cant)),
    assert(palabra(H,Car,Cant+1)),
    writeln('Ya existe.'),
    save,
    guardar(T,Car).
guardar([H|T],Car):-
    assert(palabra(H,Car,1)),
    save,
    guardar(T,Car).
guardar([],_).

save:-
    tell('D://Documentos//Prolog//Finales//IA_Final_Practica_Caracteres.txt'),
    listing(palabra/3),
    told.


/*Me canse, es cualquiera este final*/
