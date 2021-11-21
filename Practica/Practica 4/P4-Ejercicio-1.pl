/*1. Hacer un programa que permita definir las cuentas a pagar del mes (luz,
agua, alquiler, teléfono, cable, supermercado, etc.) de un grupo de
personas. A su vez, deberá permitir ingresar el nombre de una de ellas e
informar de todos sus gastos.*/

:-dynamic(gastos/3).

inicio:- writeln("ingrese la opción: 1-agregar un gasto 2-consultar gastos de la persona, otra para salir."), read(Opc), opcion(Opc).

opcion(1):- agregar, inicio.

opcion(2):- consultar, inicio.

opcion(_):- writeln("Gracias por usar el sistema."). 

agregar :- abrir_base, agregarNuevo, guardar.

abrir_base:- consult('C:/Users/Nico/Documents/Prolog/Practica 4/P4-Ejercicio-1.txt').

agregarNuevo :- write('Ingrese persona: '), read(Persona),
                write('Ingrese gasto: '), read(Gasto),
                write('Ingrese dinero: '), read(Dinero),  
                assert(gastos(Persona,Gasto,Dinero)).
        
guardar :- tell('C:/Users/Nico/Documents/Prolog/Practica 4/P4-Ejercicio-1.txt'), listing(gastos), told.

consultar :- abrir_base, writeln('Ingrese la persona a consultar: '), read(Persona), write(Persona), writeln(': '), listar_gastos(Persona).

listar_gastos(Persona) :- gastos(Persona, Gasto, Monto),  write(Gasto), write(': '), writeln(Monto), retract(gastos(Persona,Gasto,Monto)), listar_gastos(Persona).
listar_gastos(_). 