/*Probado por mi y funciona parece.*/

:-dynamic(persona/3).
:-dynamic(vacuna/3).
:-dynamic(enfermedad/3).
:-dynamic(sintoma/2).

inicio:- abrir_base, write('ingrese opcion: '), read(Opc), opciones(Opc).

opciones(1):- armarListado(Lista),writeln(Lista), inicio. 

opciones(2):- armarListado5(Lista), writeln(Lista), inicio.

opciones(3):- read(IDVACUNA), vacuna(IDVACUNA,_,ListaEnf), informe(ListaEnf, ListaRes),write(ListaRes).

opciones(_):- write('adios').

abrir_base:- retractall(persona), retractall(vacuna), retractall(enfermedad), retractall(sintoma), consult('C:/Users/Nico/Repos/InteligenciaArtificial_frro/Resolucion finales/IA_AD_2021_1er.txt').

armarListado([H|T]):- enfermedad(IdEnfermedad,_,_), retract(enfermedad(IdEnfermedad,_,_)), not(recorrerVacunas(IdEnfermedad)), H = IdEnfermedad, armarListado(T).
armarListado([]).

recorrerVacunas(IdEnfermedad):- vacuna(Id,_,ListaEnfermedades), retract(vacuna(Id,_,_)), pertenece(ListaEnfermedades,IdEnfermedad).

armarListado5([H|T]):- vacuna(Id,_,ListaEnfermedades), retract(vacuna(Id,_,ListaEnfermedades)), contarEnf(ListaEnfermedades, CantEnf), CantEnf > 5, H = Id,armarListado5(T).
armarListado5([]).  

contarEnf([], 0).
contarEnf([_|T], CantEnf):- contarEnf(T, CantParcial), CantEnf is CantParcial + 1. 

pertenece([H|_],H).
pertenece([_|T], Buscando):- pertenece(T,Buscando).

informe([],[]).
informe([Enf|Cola], ListaRes):- enfermedad(Enf,_,ListaSintomas), informe(Cola,NuevaLista), list_concat(NuevaLista,ListaSintomas, ListaRes).

list_concat([],L,L).
list_concat([X1|L1],L2,[X1|L3]) :- not(pertenece(L2,X1)),list_concat(L1,L2,L3).
list_concat([_|L1],L2,L3):- list_concat(L1,L2,L3).


