/*                                        [Final Inteligencia Artificial - 10/8/17]
Hechos:
persona(dni, nombre, edad, obraSocial, plan).
obraSocial (obra, plan, medicamento, cobertura).                       */

:- dynamic (obrasocial/4).
:- dynamic (auxos/1).
:- dynamic (persona/5).

inicio :- abrir_base,
          writeln("1 - (Lista personas mayores a 65 cuyo plan cubra al menos 10 medicamentos al 100%)"),
          writeln("2 - (Datos de personas con mas de una obra social)"),
          writeln("3 - (Salir)"),
          read(Opc), Opc \= 3, opcion(Opc).
inicio.


opcion(1) :- writeln("Listado de persona mayores a 65 con un plan que cubre al menos 10 medicamentos al 100 %:"),
             consultarPersonas, inicio.

opcion(2) :- writeln("Listados de personas con mas de una obra social"), retract(persona( Dni, Nombre, Edad, OS1, _)), retract(persona( Dni, Nombre, Edad, OS2, _)),
             retract(persona( Dni, _, _, _, _)), write("DNI: "), write(Dni), write(" - Nombre: "), write(Nombre), write(" - Edad: "), writeln(Edad), fail.

consultarPersonas :- retract( persona( Dni, _, Edad, OS, Plan)), Edad > 65, getMedCob( OS, Plan), consultaMedsCant(Cant), Cant> 10, write("DNI "), write(Dni), write(" - La cantidad "), writeln(Cant), consultarPersonas.
consultarPersonas.

consultaMedsCant(Cont) :- auxos(P), retract( auxos(P)), consultaMedsCant(Cant), Cont is Cant + 1.
consultaMedsCant(0).


getMedCob( OS, Plan) :- retractall(auxos/1), obrasocial( OS, Plan, M, 100), assert(auxos(M)),fail.
getMedCob( _, _).


abrir_base :- retractall(obrasocial/4),
              retractall(persona/5),
              consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_Final_2017-08-10.txt').