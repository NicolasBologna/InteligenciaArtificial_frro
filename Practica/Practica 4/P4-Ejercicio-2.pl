/*2. Hacer un programa que defina una Base de datos de personas de la
siguiente forma: personas(codigo,nombre).
El programa debe permitir ingresar un código y verificar si el mismo está
definido en la BBDD. De estarlo deberá informar a quién corresponde, de lo
contrario deberá solicitar ingresar un nombre y registrar entonces la
persona en la BBDD. */


:-dynamic(personas/2).

inicio:- writeln('ingrese codigo: '), read(Codigo), abrir_base, consultarPersona(Codigo), inicio.

abrir_base:- consult('C:/Users/Nico/Documents/Prolog/Practica 4/P4-Ejercicio-2.txt').

consultarPersona(Codigo):- personas(Codigo,Nombre), writeln(Nombre).
consultarPersona(Codigo):- writeln('La persona no esta cargada, por favor ingrese un nombre para hacerlo: '), read(Nombre), assert(personas(Codigo,Nombre)), guardar.

guardar:- tell('C:/Users/Nico/Documents/Prolog/Practica 4/P4-Ejercicio-2.txt'), listing(personas), told.