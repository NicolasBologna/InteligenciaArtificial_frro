/*Se tiene una Base de Datos compuesta por hechos con la siguiente estructura:

camion(cod_camion, marca, modelo, tipo_mma, peso_vacio, tipo1, tipo2, tipo3).

tipo1: Clasificación según el tipo de mercancia a transportar (‘Camión de lona’ / ‘Plataforma abierta’)
tipo2: Clasificación según Dimensiones (‘2 ejes’ / ‘3 ejes’ / ‘4 ejes’)
tipo3: Clasificación según Estructura vehículo (‘Rígido’ / ‘Articulado’ / ‘Trailer’ / ‘Tren de carretera’) 

conductor(cod_conductor, apellido_nombre, edad, ciudad_natal, [cod_camion]).

[cod_camion]: Lista de códigos de camión que el conductor está habilitado a conducir

Ejemplo de hechos con datos:
camion(1553, scania, 2015, N1, 1000, ‘Camión de lona’, ‘2 ejes’, ‘Rígido’). conductor(523, ‘Suárez Mario’, 56, ‘Rosario’, [1553,1645,1825]).


Desarrollar un programa en PROLOG que permita: 
1. Dada una lista [ ] de códigos de camiones, una marca y modelo, (datos de entrada) 
devolver una nueva lista [ ] con los códigos de camión de la lista ingresada que sean de la marca y modelo indicado.

2. Dada una lista [ ] de códigos de conductores y un código de camion (datos de entrada), 
devolver una nueva lista [ ] con los nombres de los conductores de la lista ingresada, que NO están habilitados a conducir el camión indicado. 
*/

:-dynamic(camion/8).
:-dynamic(conductor/5).

inicio:- abrir_base, writeln('Ingrese opcion de menu'), read(Opc), menu(Opc).

menu(1):- write('ingrese listas de codigos:'), leer(Lista), write('Ingrese modelo: '), read(Modelo), write('Ingrese marca: '), read(Marca), buscarCamiones(Lista,Marca,Modelo,Resultado), write(Resultado), inicio.

menu(2):- write('Ingrese lista de conductores: '), leer(Lista), write('Ingrese codigo de camion: '), read(CodCam), crearLista(Lista, CodCam, Resp), write(Resp), inicio.

menu(_):- writeln('adios').

buscarCamiones([],_,_,[]).
buscarCamiones([H|T],Marca,Modelo,[HN|TN]):- camion(H,Marca,Modelo,_,_,_,_,_), retract(camion(H,Marca,Modelo,_,_,_,_,_)), HN = H, buscarCamiones(T,Marca,Modelo,TN).
buscarCamiones([_|T],M,Mod,Lista):- buscarCamiones(T,M,Mod,Lista).

crearLista([],_,[]).
crearLista([H|T], CodCam, [HN|TN]):- conductor(H,ApellidoNombre,_,_, Camiones), retract(conductor(H,ApellidoNombre,_,_, Camiones)), not(pertenece(Camiones, CodCam)), HN = ApellidoNombre, crearLista(T,CodCam,TN).
crearLista([_|T], CodCam, ListaNueva):- crearLista(T, CodCam,ListaNueva).

abrir_base:- retractall(camion), retractall(conductor),consult('C:/Users/Nico/Repos/InteligenciaArtificial_frro/Resolucion finales/IA_Final_Practica_2020-08-12.txt').

leer([H|T]):- read(H), H\=[],leer(T).
leer([]).

pertenece([H|_],H).
pertenece([_|T],Cod):-pertenece(T,Cod).