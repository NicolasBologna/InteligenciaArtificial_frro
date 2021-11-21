/* Dada una BD con:

    cantante(nombre_cantante, pais_origen)
    album(nombre_album, nombre_cantante, [lista_temas]), fecha_edicion, copias_vendidas)

    (El formato del campo fecha es dd/mm/aaaa)

3)Ingresar un cantante y devolver una lista con todos los albumes que haya lanzado 
a lo largo de su carrera y cuya cantidad de copias supere el millán.

De las cosas más locas que habáa en las consignas estaba el tema de sacar la fecha(dd/mm/aaaa). 
Para eso habáa que usar el predicado sub_atom, sub_atom(fecha_edicián,6,4,_,Año).

*/

:- dynamic(cantante/2).
:- dynamic(album/5).

inicio :- writeln("1-(Buscar Album por nombre y canciones)"),
          writeln("2-(Cantidad de albumes por año)"),
          writeln("3-(Lista de albumes por cantante)"),
          writeln("4-(Salir)"), read(Opc), Opc \= 4, opcion(Opc).
inicio.

opcion(1) :- abrir_base, writeln("Ingrese el Album:"), read(A), album(A, _, Lista, _, _), leer(L), compara(L, Lista, Dev), mostrarLista(Dev), inicio.
opcion(1) :- writeln("El Album no existe"), inicio.

opcion(2) :- abrir_base, writeln("Ingrese año de albumes a buscar: "), read(Fecha), contarAlbumes(Fecha, Cant),
             write("Para el año seleccionado se encontraron "), write(Cant), writeln(" albumes presentados"), inicio.

opcion(3) :- abrir_base, writeln("Ingrese un cantante"), read(C), getExitosCantante(C, ListaAlbumes),
             writeln("Los albumes del cantante que superan el millon de copias vendidas son:"),
             mostrarAlbumes(ListaAlbumes), inicio.

getExitosCantante(C, [H|T]) :- retract(album(H, C, _, _, CCV)), CCV > 1000000, getExitosCantante(C, T).
getExitosCantante( _, []):- writeln("termina busqueda").

contarAlbumes(Fecha, Cant) :- retract(cantante(Cantante, 'suecia')), contarAlbumCantanteFecha( Fecha, Cantante, Cant2), contarAlbumes(Fecha, Cant3), Cant is Cant2 + Cant3.
contarAlbumes( _, 0).

contarAlbumCantanteFecha(Fecha, Cantante, Cant) :- retract(album(_, Cantante, _, FechRaw, _)), sub_atom(FechRaw, _, 4, 0, Fecha), contarAlbumCantanteFecha( Fecha, Cantante, Cant2), Cant = Cant2 + 1.
contarAlbumCantanteFecha( _, _, 0).

mostrarAlbumes([H|T]) :- write(" Album: "), writeln(H), mostrarAlbumes(T).
mostrarAlbumes([]).

mostrarLista([H|T]) :- write(" Cancion: "), writeln(H), mostrarLista(T).
mostrarLista([]).

mostrar([H|T]):- writeln(H),mostrar(T).
mostrar([]).

compara([H|T], ListaO, [H|T1]) :- pertenece(H, ListaO), compara(T, ListaO, T1).
compara([_|T], ListaO, L) :- compara(T, ListaO, L).
compara([], _, []).

pertenece(X,[X|_]).
pertenece(X,[_|T]):- pertenece(X,T).

leer([H|T]) :- writeln("Ingrese un tema o [] para salir"), read(H), H \= [], leer(T).
leer([]).

abrir_base :- retractall(cantante/2), retractall(albumes/5), consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_Final_2017-04.txt').