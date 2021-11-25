/*
Cliente(dni,nombre,obrasocial).
Practica(cod,medico,fecha,dnicliente,asistio).

Ingresar un dni y buscar si el cliente entre todas sus practicas falto mas de un 80% y asi escribir si es posible que falte o no.
Si no hay practicas registradas para ese cliente informar que no hay datos suficientes para saberlo.
*/
:- dynamic cliente/3.
:- dynamic practica/5.

abrirBase:- consult('D:/Documentos/Prolog/Finales/IA_Final_Practica_2017-03-09.txt').

inicio:- abrirBase, write('Ingrese DNI: '), read(DNI), getAusencias(DNI,Ausencias), abrirBase, getTotal(DNI,Total), mostrarMensaje(Ausencias,Total).

getAusencias(DNI,Ausencias):-
    cliente(DNI,_,_),
    retract(practica(_,_,_,DNI,no)),
    getAusencias(DNI,AcumAusencias),
    Ausencias is AcumAusencias + 1.
getAusencias(_,0).

getTotal(DNI,Total):-
    cliente(DNI,_,_),
    retract(practica(_,_,_,DNI,_)),
    getTotal(DNI,AcumTotal),
    Total is AcumTotal + 1.
getTotal(_,0).

mostrarMensaje(_,0):-
    write('No hay datos suficientes.').
mostrarMensaje(Ausencias,Total):-
    Ausencias/Total < 0.8,
    write('Puede faltar.').
mostrarMensaje(_,_):-
    write('No puede faltar.').






















