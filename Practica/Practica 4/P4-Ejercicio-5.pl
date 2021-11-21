/*
5. Hacer un programa que permita realizar altas, bajas y consultas a la base
de datos de una librería. De cada libro se registran los siguientes datos:
• Nro. de libro (auto numérico)
• Titulo
• Autor
• Editorial
• Precio
La base datos debe guardarse en disco.
Calcular además el precio promedio de los libros de un determinado autor. */

:-dynamic(libro/5).

inicio:- writeln("Ingrese la opcion deseada: 1-Alta 2-Baja 3-Consulta 4-Precio promedio por autor otro-Salir: "), read(Opc), opcion(Opc).

opcion(1):- abrir_base, alta, guardar, inicio.

opcion(2):- abrir_base, baja, guardar, inicio.

opcion(3):- abrir_base, consulta, inicio.

opcion(4):- abrir_base, precioPromedio, inicio.

opcion(_).


abrir_base:- retractall(libro), consult('C:/Users/Nico/Documents/Prolog/Practica 4/P4-Ejercicio-5.txt').

guardar:- tell('C:/Users/Nico/Documents/Prolog/Practica 4/P4-Ejercicio-5.txt'), listing(libro), told.

alta:- obtener_indice(Indice), abrir_base, NuevoIndice is Indice + 1, write("Ingrese Titulo"), read(Titulo)
                                                        , write("Ingrese Autor"), read(Autor)
                                                        , write("Ingrese Editorial"), read(Editorial)
                                                        , write("Ingrese Precio"), read(Precio),
        assert(libro(NuevoIndice,Titulo,Autor,Editorial,Precio)).

obtener_indice(Indice):- libro(IndiceLibro,_,_,_,_), retract(libro(IndiceLibro,_,_,_,_)), obtener_indice(IndiceResto), Indice is IndiceResto + 1.

obtener_indice(0).

baja:- write("Ingrese el indice del libro a eliminar: "), read(Indice), libro(Indice,Titulo,Autor,Editorial,Precio), retract(libro(Indice,_,_,_,_)), write("Se eliminó el libro: "), writeln(Titulo), writeln(Autor), writeln(Editorial),writeln(Precio).

baja:- writeln("El libro que desea eliminar no se encuentra.").

consulta:- write("Ingrese el indice del libro a consultar: "), read(Indice), libro(Indice,Titulo,Autor,Editorial,Precio), write("Información del libro: "), writeln(Titulo), writeln(Autor), writeln(Editorial),writeln(Precio).

consulta:- writeln("El libro que desea consultar no se encuentra.").

precioPromedio:- write("Ingrese el autor a consultar: "), read(Autor), libro(_,_,Autor,_,_), write("Buscando por autor: "), writeln(Autor),calcularPromedio(Autor, Cantidad, Total), Promedio is Total/Cantidad, writeln(Promedio).

precioPromedio:- writeln("El autor que desea buscar no se encuentra.").

calcularPromedio(Autor,Cantidad, Total):- libro(_,_,Autor,_,Precio), retract(libro(_,_,Autor,_,Precio)), calcularPromedio(Autor,CantidadParcial, TotalParcial), Cantidad is CantidadParcial + 1, Total is TotalParcial + Precio.

calcularPromedio(_,0,0).