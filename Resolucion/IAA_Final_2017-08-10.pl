/*                                        [Final Inteligencia Artificial - 10/8/17]
Hechos:
persona(dni,nombre,edad,obraSocial,plan).
obraSocial (obra,plan, medicamento,%cobertura).

1- devolver una lista con los DNI de las personas que tengan más de 65 años y cuyo plan cubra al menos 10 medicamentos al 100%.
2- devolver los datos de aquellas personas que tengan más de una obra social.
(Atentos con el segundo ejercicio, según Laura "casi nadie lo hizo bien, porque era bien sencillo y todos se entreveraron". 
Era con fail, no con retract.)                                                                                                 */

:- dynamic (obraSocial/4).
:- dynamic (persona/5).

inicio :- abrir_base. menu.

menu :- writeln("1 - (Lista personas mayores a 65 cuyo plan cubra al menos 10 medicamentos al 100%)"),
        writeln("2 - (Datos de personas con mas de una obra social)"),
        writeln("3 - (Salir)").

abrir_base :- retractall(obraSocial/4),
              retractall(persona/5),
              consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_Final_2017-08-10.txt').