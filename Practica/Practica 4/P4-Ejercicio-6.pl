/*
6. Hacer un programa que permita registrar en una Base de Datos recetas
de cocina. De cada receta se registran los siguientes datos:
• Código de receta
• Nombre de la receta
Y por cada ingrediente que contenga la receta:
• Nombre del ingrediente
• Cantidad
A su vez, permitir ingresar dos (2) ingredientes e informar de todas las
recetas (Código y Nombre) que poseen ambos ingredientes.
Por otro lado, para un ingrediente en particular y una cierta cantidad del
mismo, determinar aquellas recetas que llevan ese ingrediente y superan
dicha cantidad.
*/

/*DB*/
:-dynamic(receta/2).
:-dynamic(ingrediente/3).

working_directory(_, 'C:/Users/Nico/Repos/InteligenciaArtificial_frro/Practica').

abrir_base:- retractall(receta), retractall(ingrediente),consult('Practica 4/P4-Ejercicio-6.txt').

guardar:- tell('Practica 4/P4-Ejercicio-6.txt'), listing(receta), listing(ingredientes), told.

/*Main*/

inicio :- writeln("Ingrese la opción: 1- Cargar Receta 2-Listar Recetas 3-Buscar por ingrediente: "), read(Opc), menu(Opc).

menu(1):- abrir_base, datos_receta(Codigo), agregar_ingredientes(Codigo), guardar, inicio.

menu(2):- abrir_base, listar_recetas, inicio.

menu(3):- abrir_base, listar_recetas_ingrediente, inicio.

menu(_).

/*Reglas 1*/

datos_receta(Codigo):- write("ingrese Codigo de la receta: "), read(Codigo), write("Ingrese nombre de la receta: "), read(NombreReceta), assert(receta(Codigo,NombreReceta)). 

agregar_ingredientes(Codigo):-  write("ingrese nombre del ingrediente: "), read(NombreIngrediente), 
                                write("Ingrese cantidad: "), read(CantidadIngrediente), assert(ingrediente(Codigo,NombreIngrediente,CantidadIngrediente)), 
                                write("Desear agregar otro ingrediente? si/no"), read(AgregarIngrediente), AgregarIngrediente == 'si', agregar_ingredientes(Codigo).

agregar_ingredientes(_).

/*Reglas 2*/

listar_recetas:- write("ingrese nombre del ingrediente 1: "), read(Ingrediente1), write("ingrese nombre del ingrediente 2: "), read(Ingrediente2), writeln("Recetas: "),buscar_recetas(Ingrediente1, Ingrediente2).

buscar_recetas(Ingrediente1,Ingrediente2):- ingrediente(CodigoReceta,Ingrediente1,_), ingrediente(CodigoReceta,Ingrediente2,_), receta(CodigoReceta,NombreReceta), write(CodigoReceta), write(", "),
                                            writeln(NombreReceta), retract(ingrediente(CodigoReceta,Ingrediente1,_)), buscar_recetas(Ingrediente1,Ingrediente2).

buscar_recetas(_,_).

/*Reglas 3*/

listar_recetas_ingrediente:-write("ingrese nombre del ingrediente: "), read(Ingrediente), write("ingrese cantidad: "), read(Cantidad),writeln("Recetas: "), buscar_recetas_ingrediente(Ingrediente, Cantidad).

buscar_recetas_ingrediente(Ingrediente, Cantidad):- ingrediente(CodigoReceta,Ingrediente,CantidadNecesaria), CantidadNecesaria > Cantidad , receta(CodigoReceta,NombreReceta), write(CodigoReceta), write(", "),
                                            writeln(NombreReceta), retract(ingrediente(CodigoReceta,Ingrediente,_)), buscar_recetas_ingrediente(Ingrediente, Cantidad).

buscar_recetas_ingrediente(_,_).


