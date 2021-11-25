/*
 * Dada una BD con:
cantante(nombre_cantante,pais_origen)
album(nombre_album,nombre_cantante,[lista_temas]),fecha_edicion,copias_vendidas)
(El formato del campo fecha es dd/mm/aaaa)
1)Ingrese un álbum y una lista [] de temas y a partir de esto devolver una lista
con aquellos temas de la lista original que correspondan al álbum ingresado.
2)Informar cuantos álbumes fueron lanzados en un determinado año (dato de entrada)
por cantantes de origen sueco.
3)Ingresar un cantante y devolver una lista con todos los albumes que haya lanzado
a lo largo de su carrera y cuya cantidad de copias supere el millón.
De las cosas más locas que había en las consignas estaba el tema de sacar la fecha(dd/mm/aaaa).
Para eso había que usar el predicado sub_atom, sub_atom(fecha_edición,6,4,_,Año).
En la primera parte tuve algunos errores, entre ellos usar mal el backtracking en los puntos 1, 2
y además me olvide la longitud esperada para el corte cuando usaba sub_atom. Sin embargo pase a la
teoría, en esta instancia me hizo varias preguntas la profesora.
1- Cuales son los problemas recuperables, no recuperables y ignorables, explicación y algunos ejemplos
para cada uno.
2- Que tipo de estructura de control se utiliza para cada uno de ellos.
3- Verificación de restricciones
4- Como esta formado un argumento, de que forma demostraría la validez de un argumento cuando el mismo es
corto, es decir, cuando esta compuesto por una o dos sentencias.
5- Como lo demostraría la validez de un argumento cuando esta compuesto por muchos enunciados.
6- Que son las reglas de inferencia y para que se usan.
7- Como esta compuesto un sistema experto
8- Ventajas de una red neuronal, aca le nombre la capacidad de aprendizaje y me dijo que le enuncie las
distintas formas de aprender que tienen.
*/
:- dynamic(album/5).
:- dynamic(cantante/2).

inicio:-
	write('1-Ver temas en album 2-Cantidad de albumes suecos 3-Ver exitos de un cantante 4-Salir Ingrese opcion: '),
	read(O),
	menu(O).

menu(1):-
	abrirBase,
	writeln('Ingrese lista de temas: '),
	leer(Temas),
	writeln('Ingrese nombre de album_ '),
	read(Album),
	album(Album,_,TemasAlbum,_,_),
	filtrarTemas(Temas,TemasAlbum,ListaFiltrada),
	mostrar(ListaFiltrada),
	inicio.

menu(2):-
	abrirBase,
	writeln('Ingrese año: '),
	read(Anio),
	contarAlbumes(Anio,Cant),
	write('En el año '), write(Anio), write(' se lanzaron '), write(Cant), write(' albumes suecos.'),
	inicio.

menu(3):-
	abrirBase,
	writeln('Ingrese un cantante: '),
	read(Cantante),
	getExitosCantante(Cantante,Albumes),
	mostrar(Albumes),
	inicio.

abrirBase:-
        retractall(cantante/2),
        retractall(album/5),
        consult('D://Documentos//Prolog//Finales//IA_Final_Practica_2017-04.txt').

filtrarTemas([H|T1],TemasAlbum,[H|T2]):-
	pertenece(H,TemasAlbum),
	filtrarTemas(T1,TemasAlbum,T2).
filtrarTemas([_|T1],TemasAlbum,ListaFiltrada):-
	filtrarTemas(T1,TemasAlbum,ListaFiltrada).
filtrarTemas(_,_,_).

contarAlbumes(Anio,Cant):-
	retract(cantante(Cantante,'Suecia')),
	contarAlbumesCantante(Cantante,Anio,CantC),
	contarAlbumes(Anio,Acum),
	Cant is Acum+CantC.
contarAlbumes(_,0).

contarAlbumesCantante(Cantante,Anio,CantC):-
	retract(album(_,Cantante,_,Fecha,_)),
	sub_atom(Fecha,_,4,0,Anio),
	contarAlbumesCantante(Cantante,Anio,AcumC),
	CantC is AcumC+1.
contarAlbumesCantante(_,_,0).

getExitosCantante(Cantante,[A|T]):-
	retract(album(A,Cantante,_,_,Copias)),
	Copias >= 1000000,
	getExitosCantante(Cantante,T).
getExitosCantante(Cantante,[A|T]):-
	retract(album(A,Cantante,_,_,Copias)),
	Copias < 1000000,
	getExitosCantante(Cantante,T).
getExitosCantante(_,[]).

mostrar([H|T]):- writeln(H),mostrar(T).
mostrar([]).

pertenece(X,[X|_]).
pertenece(X,[_|T]):- pertenece(X,T).

leer([H|T]):-
	read(H),
	H\=[],
	leer(T).
leer([]).
