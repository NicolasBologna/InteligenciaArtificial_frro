
%niño(nombre, edad, [vacunas_aplicadas]).
%vacunas_edad(edad_desde, edad_hasta, vacunas_a_aplicarse).
%vacuna(vacuna, [enfermedades_que_cura]).

/* 
Hacer un programa que permita lo siguiente:
-Ingresar el nombre de un niño y según la edad, mostrar una lista con las vacunas que le falta aplicarse.
-Ingresar una enfermedad y mostrar la cantidad de vacunas que la curan.
*/

:-dynamic(ninio/3).
:-dynamic(vacunas_edad/3).
:-dynamic(vacuna/2).

menu :- writeln("1 - (Consultar vacunas faltantes por listado ingresado el nombre de un  niño)"),
        writeln("2 - (Consultar vacunas que curan un enfermedad ingresada)"),
        writeln("3 - (Salir)"), read(Opc), Opc \= 3, opcion(Opc), menu.

opcion(1) :- writeln("Ingrese el nombre del niño"), read(N), ninio(N,Edad, Aplicadas), consulta(Edad, Aplicadas, Listado), writeln(Listado), menu.

consulta(Edad, Aplicadas, Listado) :- vacunas_edad(EdadD, EdadH, Necesarias), Edad >= EdadD, Edad < EdadH, compara(Aplicadas, Necesarias, Lista), 
                     retract(vacunas_edad(Edad2, _, Necesarias)), concatenar(Listado, Lista, Salida), consulta(Edad, Aplicadas, Salida).
                                                                % concatenar deberia ir dps segun esto ya q suma o usa contador dps de llamarse a si mismo
compara(Aplicadas, [HN|TN], [HN|T]):- not(pertenece(HN, Aplicadas)), compara(Aplicadas, TN, T).
compara(Aplicadas, [_|TN], S) :- compara(Aplicadas, TN, S).
compara(_ , [], []).

pertenece(X, [X|_]).
pertenece(X, [_|T]) :- pertenece(X,T).

concatenar([H1|T1], L2, [H1|T3]) :- concatenar(T1, [H2|T2], T3).
concatenar([], [H2|T2], [H2|T3]) :- concatenar(T1, T2, T3).
concatenar([],[],_).