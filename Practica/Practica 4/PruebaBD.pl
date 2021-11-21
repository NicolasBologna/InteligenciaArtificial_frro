:-dynamic(padres/3).

inicio:-abrir_base,
        agregarNuevo,
        guardar.

abrir_base:- consult('C:/Users/Nico/Documents/Prolog/Practica 4/base.txt').

agregarNuevo:- write('Ingrese hijo: '), read(H),
                write('Ingrese madre: '), read(M),
                write('Ingrese padre: '), read(P),
                assert(padres(H,M,P)).

guardar:-tell('C:/Users/Nico/Documents/Prolog/Practica 4/base.txt'), listing(padres), told.
