/* camion(cod_camion, marca, modelo, tipo_mma, peso_vacio, tipo1, tipo2, tipo3).

tipo1: Clasificación según el tipo de mercancia a transportar (‘Camión de lona’ / ‘Plataforma abierta’)
tipo2: Clasificación según Dimensiones (‘2 ejes’ / ‘3 ejes’ / ‘4 ejes’)
tipo3: Clasificación según Estructura vehículo (‘Rígido’ / ‘Articulado’ / ‘Trailer’ / ‘Tren de carretera’) 

conductor(cod_conductor, apellido_nombre, edad, ciudad_natal, [cod_camion]).

[cod_camion]: Lista de códigos de camión que el conductor está habilitado a conducir  */

:- dynamic(camion/8).
:- dynamic(conductor/5).

inicio :- menu.

menu :- writeln("1 - (Listar codigos de camion por Marca y Modelo)"),
        writeln("2 - (Buscar conductores no habilitados a un camion)"),
        writeln("3 - (Salir)"), read(Opc), Opc \= 3, opcion(Opc), inicio.
menu :- writeln("Muchas gracias").

opcion(1) :- abrir_base, leer(L),
             writeln("Ingrese marca"), read(Marca),
             writeln("Ingrese modelo"), read(Modelo),
             proceso(L, Marca, Modelo, LSalida),
             write("Lista de camiones de la marca: "), write(Marca),
             write(" y modelo: "), write(Modelo), writeln(" buscados:"),
             muestraCodCam(LSalida).

% camion(cod_camion, marca, modelo, tipo_mma, peso_vacio, tipo1, tipo2, tipo3).
% conductor(cod_conductor, apellido_nombre, edad, ciudad_natal, [cod_camion]).

opcion(2) :- abrir_base, writeln("Ingrese el camion"), read(C),
             writeln("Ingrese el listado de conductores"), leer2(Lista),
             filtraLista( C, Lista, LSalida), write("El listado de Conductores No hablitados para el Camion "),
             writeln(C), mostrarListaFiltrada(LSalida).

filtraLista( C, [H|T1], [Nombre|T2]) :- conductor(H,Nombre, _, _, CodsCam), not(pertenece( C, CodsCam)), filtraLista( C, T1, T2).
filtraLista( C, [_|T1], T2) :- filtraLista( C, T1, T2).
filtraLista( _, [], []).

pertenece( H, [H|_]).
pertenece( H, [_|T]) :- pertenece( H, T).

leer2([H|T]):- writeln("Ingrese codigo de Conductor o [] para finalizar"), read(H), H \= [], leer2(T).
leer2([]).

mostrarListaFiltrada([H|T]) :- writeln(H), mostrarListaFiltrada(T).
mostrarListaFiltrada([]).

proceso([H|T], M, Mod, [H|T2]) :- camion(H, M, Mod, _, _, _, _, _), writeln("pasa por ak"), proceso( T, M, Mod, T2).
proceso([_|T], M, Mod, L) :- proceso(T, M, Mod, L).
proceso([], _, _, []).

muestraCodCam([H|T]) :- write(" - Codigo de Camion: "), writeln(H), muestraCodCam(T).
muestraCodCam([]).

leer([H|T]) :- writeln("Ingrese el código del camion o [] para terminar"), read(H), H \=[], leer(T).
leer([]).

abrir_base :- retractall(camion/8), retractall(conductor/5),
              consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_Final_2020-08-12.txt').