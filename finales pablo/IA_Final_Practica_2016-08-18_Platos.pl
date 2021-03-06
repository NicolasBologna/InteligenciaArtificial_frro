/*
 * menu(idMenu, nomMenu, [lista idPlato])
Plato(idPlato, descripci?n, tipo, tieneSal, tieneGluten).
Tipo puede ser entrada, plato principal, postre.
1. Dado un nombre de menu decir cuantos de sus platos contienen gluten.
2. Listar aquellos menu que ninguno de sus platos contiene sal.
 *
 */

:-dynamic(menu/3).
:-dynamic(plato/5).

inicio:-
    write('1- Mostrar cantidad de platos con gluten 2- Listar men?es con platos sin sal Opcion: '),
    read(O),
    opcion(O).

abrirBase:-
    retractall(plato/5),
    consult('D:/Documentos/Prolog/Finales/IA_Final_Practica_2016-08-18_Platos.txt').

opcion(1):-
    abrirBase,
    write('Ingrese menu: '),
    read(M),
    menu(_,M,Platos),
    getCantGluten(Platos,Cant),
    write(Cant).
opcion(1):-
    writeln('No existe el menu').

opcion(2):- %RESUELTO DE DOS MODOS: ARMANDO UNA LISTA Y MOSTRANDO Y MOSTRANDO DIRECTAMENTE
    abrirBase,
    getSinSal.
    %getSinSal(Lista),
    %mostrar(Lista).

getCantGluten([H|T],Cant):-
    retract(plato(H,_,_,_,G)),
    G=1,
    getCantGluten(T,Acum),
    Cant is Acum+1.
getCantGluten([_|T],Cant):-
    getCantGluten(T,Cant).
getCantGluten([],0).
/*
getSinSal([H|T]):-
    retract(menu(_,H,Platos)),
    noTieneSal(Platos),
    %H is Desc,
    getSinSal(T).
getSinSal([]).
*/

getSinSal:-
    retract(menu(_,Desc,Platos)),
    noTieneSal(Platos),
    writeln(Desc),
    getSinSal.
getSinSal.

noTieneSal([H|T]):-
    plato(H,_,_,S,_),
    S=0,
    noTieneSal(T).
noTieneSal([]).


mostrar([H|T]):-
    write(H),
    mostrar(T).
mostrar([]).

