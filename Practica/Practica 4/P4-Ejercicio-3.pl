/*3. Desarrollar un programa que permita definir los hábitos de:
• alimentación (comida, cantidad)
• bebida (bebida, cantidad)
• reproducción (época de reproducción, período de gestación)
• horas de sueño
de un conjunto de animales de un Zoo.
Dicha información se guardará en una base de datos.
El programa, deberá permitir:
a. Ingresar el nombre de un animal e informar de todos sus hábitos.
b. Ingresar un hábito e informar todos los animales que lo tienen. */

:-dynamic(animal/2).

inicio:- writeln('Seleccione la opcion a realizar: 1- agregar animal, 2- informar animales, otro- salir'), read(Opc), opcion(Opc), inicio.

opcion(1):- abrir_base, agregar_habitos.

opcion(2):- abrir_base, write('Ingrese habito'), read(Habito), informar(Habito).

opcion(_).

abrir_base:- consult('C:/Users/Nico/Documents/Prolog/Practica 4/P4-Ejercicio-3.txt').

agregar_habitos:- write('ingrese animal') ,read(Animal), write('ingrese comida'), read(Comida),
                                                         write('ingrese cantidad'), read(Cantidad),
                                                         assert(animal(Animal,alimentacion(Comida,Cantidad))),
                                                         write('ingrese bebida'), read(Bebida),
                                                         write('ingrese cantidad'), read(CantidadBebida),
                                                         assert(animal(Animal,bebida(Bebida,CantidadBebida))),
                                                         write('ingrese época de reproducción'), read(EpocaRep),
                                                         write('ingrese período de gestación'), read(PerGestacion),
                                                         assert(animal(Animal,reproduccion(EpocaRep,PerGestacion))),
                                                         write('ingrese horas de sueño'), read(HorasSuenio),
                                                         assert(animal(Animal,horasSuenio(HorasSuenio))),
                                                         guardar.

guardar:- tell('C:/Users/Nico/Documents/Prolog/Practica 4/P4-Ejercicio-3.txt'), listing(animal), told.

informar(Habito):- animal(NombreAnimal, FunctorCargado),  functor(FunctorCargado, Habito,_), write(NombreAnimal), write(' ') ,writeln(FunctorCargado), retract(animal(Habito,_)), informar(Habito).
informar(_).


