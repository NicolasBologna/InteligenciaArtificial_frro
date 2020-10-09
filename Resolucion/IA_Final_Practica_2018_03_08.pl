
%niño(nombre, edad, [vacunas_aplicadas]).
%vacuna_edad(edad_desde, edad_hasta, vacunas_a_aplicarse).
%vacuna(vacuna, [enfermedades_que_cura]).

/* 
Hacer un programa que permita lo siguiente:
-Ingresar el nombre de un niño y según la edad, mostrar una lista con las vacunas que le falta aplicarse.
-Ingresar una enfermedad y mostrar la cantidad de vacunas que la curan.
*/

:-dynamic(nino/3).
:-dynamic(vacuna_edad/3).
:-dynamic(vacuna/2).

menu :- writeln("1 - (Consultar vacunas faltantes por listado ingresado el nombre de un  niño)"),
        writeln("2 - (Consultar vacunas que curan un enfermedad ingresada)"),
        writeln("3 - (Salir)"), read(Opc), Opc \= 3, opcion(Opc), menu.
menu :- writeln("Q tenga buen dia").

opcion(1) :- abrir_base, writeln("Ingrese el nombre del niño"), read(N), nino(N,Edad, Aplicadas), consulta(Edad, Aplicadas, Listado), 
             write("Las vacunas faltantes son "), writeln(Listado), menu.

opcion(2) :- abrir_base, writeln("Ingrese una enfermedad"), read(N), consulta2(N, Cant), write("La cantidad de vacunas que la curan son: "), writeln(Cant), menu.

consulta2(N, Cant) :- retract(vacuna(_, Lista)), pertenece(N, Lista), consulta2(N, Cant2), Cant is Cant2 + 1.
consulta2(_, 0).

consulta(Edad, Aplicadas, Listado) :- vacuna_edad(EdadD, EdadH, Necesarias), Edad >= EdadD, Edad < EdadH, retract(vacuna_edad(EdadD, EdadH, Necesarias)), 
                                      compara(Aplicadas, Necesarias, Lista), consulta(Edad, Aplicadas, Salida), concatenar(Lista, Salida, Listado).
consulta(_, _, []).

compara(Aplicadas, [HN|TN], [HN|T]):- not(pertenece(HN, Aplicadas)), compara(Aplicadas, TN, T).
compara(Aplicadas, [_|TN], S) :- compara(Aplicadas, TN, S).
compara(_ , [], []).

pertenece(X, [X|_]).
pertenece(X, [_|T]) :- pertenece(X,T).

concatenar([H1|T1], L2, [H1|T3]) :- concatenar(T1, L2, T3).
concatenar([], [H2|T2], [H2|T3]) :- concatenar([], T2, T3).
concatenar([],[],[]).

abrir_base :- retractall(nino/3), retractall(vacuna_edad/3), retractall(vacuna/2), consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IA_Final_Practica_2018_03_08.txt').