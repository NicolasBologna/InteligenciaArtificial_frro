:-dynamic(almacen/3).
:-dynamic(sucursal/4).
:-dynamic(producto/5).

abrir_base:- retractall(almacen), retractall(sucursal), retractall(producto), consult('C:/Users/Nico/Repos/InteligenciaArtificial_frro/Resolucion finales/IA_Final_AD_2020.txt').

inicio:- abrir_base, write('ingrese 1 para cant empleados, 2 devolver listas, otro para salir.'), read(Opc), opciones(Opc).

opciones(1):- write('ingrese id almacen: '), read(IDAlmacen), almacen(IDAlmacen,_,ListaSuc), contarEmpleados(ListaSuc,Cant), write('cantidad de empleados: '), write(Cant), inicio. 

opciones(2):- write('ingrese la lista de prod: '), leer(Lista), dividir_por_vencimiento(Lista,Lista2020,Lista2021,Resto), writeln(Lista2020), writeln(Lista2021), writeln(Resto),inicio.

opciones(_).


contarEmpleados([H|T], Cant):- sucursal(H,_,_,CantS), contarEmpleados(T,CantPar), Cant is CantPar+CantS.
contarEmpleados(_,0).

dividir_por_vencimiento([H|T],[H|T20],Lista2021,ListaResto):- producto(H,_,_,FVen,_), sub_atom(FVen,_,4,0,'2020'), dividir_por_vencimiento(T,T20,Lista2021,ListaResto).
dividir_por_vencimiento([H|T],Lista2020,[H|T21],ListaResto):- producto(H,_,_,FVen,_), sub_atom(FVen,_,4,0,'2021'), dividir_por_vencimiento(T,Lista2020,T21,ListaResto).
dividir_por_vencimiento([H|T],Lista2020,Lista2021,[H|TR]):- producto(H,_,_,_,_), dividir_por_vencimiento(T,Lista2020,Lista2021,TR).
dividir_por_vencimiento([],[],[],[]).

leer([H|T]):- read(H), H\=[], leer(T). 
leer([]).

