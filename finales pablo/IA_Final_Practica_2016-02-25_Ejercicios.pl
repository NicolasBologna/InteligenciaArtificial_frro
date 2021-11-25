/*Socio(dni, apellido, sexo, edad)
Ejercicio(cod, descripcion, cod.nivel, sexorecomendado, edaddesde, edadhasta)
Asistencia(fecha, dni, minentreno, [codejercicios realizados])
Nivel(cod nivel, descripcion, canthoradesde, canthorahasta)
A tener en cuenta:
Nivel: inicial (de 0 hs a 72 hs) medio (de tanto a tanto) avanzado (de tanto a tanto) y extremo(de tanto a tanto)

1. Ingresar un dni de un socio e informar:
a. El nivel en el que se encuentra (teniendo en cuenta la asistencia)
b. Los ejercicios que recomienda realizar de acuerdo a su nivel, sexo y edad.
2. Ingresar una fecha y un cod ejercicio e informar los socios que lo realizaron en esa fecha.

*
*/

:- dynamic(asistencia/4).
:- dynamic(socio/4).
:- dynamic(nivel/4).
:- dynamic(ejercicio/6).

abrirBase:-
    retractall(asistencia/4),
    retractall(socio/4),
    retractall(nivel/4),
    retractall(ejercicio/6),
    consult('D:/Documentos/Prolog/Finales/IA_Final_Practica_2016-02-25.txt').

inicio:-
   write('Ingrese 1-Mostrar nivel de un socio 2- Ingrese: '),
   read(O),
   menu(O).

menu(1):-
    abrirBase,
    write('Ingrese DNI: '),
    read(DNI),
    socio(DNI,_,Sexo,Edad),
    contarHoras(DNI,Mins),
    Hs is Mins/60,
    getNivel(Hs,Nivel),
    getEjercicios(Nivel,Sexo,Edad).
menu(1):-
    writeln('Socio no encontrado.'),
    inicio.

menu(2):-
    abrirBase,
    write('Ingrese fecha: '),
    read(F),
    write('Ingrese codigo de ejercicio: '),
    read(C),
    getSocios(F,C).


contarHoras(DNI,Mins):-
    retract(asistencia(_,DNI,Min,_)),
    contarHoras(DNI,Acum),
    Mins is Acum+Min.
contarHoras(_,0).

getNivel(Hs,Cod):-
    retract(nivel(Cod,Desc,Min,Max)),
    Hs<Max,
    Hs>=Min,
    writeln(Desc).
getNivel(_,_).

getEjercicios(N,S,E):-
    retract(ejercicio(_,Desc,N,S,EMin,EMax)),
    E<EMax,
    E>=EMin,
    writeln(Desc),
    getEjercicios(N,S,E).
getEjercicios(_,_,_).

getSocios(F,C):-
    retract(asistencia(F,DNI,_,Ejercicios)),
    pertenece(C,Ejercicios),
    retract(socio(DNI,Apellido,_,_)),
    writeln(Apellido),
    getSocios(F,C).
getSocios(_,_).

pertenece(X,[X|_]).
pertenece(X,[_|T]):- pertenece(X,T).



