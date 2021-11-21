/*
[IA] Inteligencia Artificial Final 17/12/2015

La base de hechos estaba formada por:

cancion(IdCancion,Nombre,Artista,Duración,Genero)
invitados(Nombre, [IdCanciones que gusta]) Tenía un atributo mas que no me acuerdo pero no se usaba

1- Listar las canciones que le gusta a mas del 80% de los invitados.
2- Listar las canciones de género "vals" que duren mas de 15 minutos.

Nota: fijense esto del punto 1, lo que pueden hacer es crear 2 bases de hechos, una con los hechos de canciones
 y otro con la de los invitados, y cuando busco por canción todos los invitados y los elimino con un retract,
  luego los vuelvo a cargar (a los invitados) ya que son bases diferentes.  */

:-dynamic(cancion/5).
:-dynamic(invitado/2).
:-dynamic(invaux/2).

abrir_base :- retractall(cancion/5), retractall(invitado/2),
              consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_Final_2015-12-17.txt').

menu :- abrir_base, writeln("1 - (Listar canciones que agrade a mas del 80% de los invitados)"),
        writeln("2 - (Listar Canciones de genero Vals que tengan una duracion de mas de 15 min)"),
        writeln("3 - (Salir)"), read(Opc), Opc \= 3, opcion(Opc), menu.
menu :- writeln("Que tenga un buen dia").

opcion(1) :- getI(Total), obtenerListado2(Total, Lista), write("Lista de canciones con mas de un 80% de popularidad "), writeln(Lista).

opcion(2) :- retract(cancion(_, N, _, D, 'Vals')), D >= 15, write("Nombre: "), write(N), write(" - Duracion: "), writeln(D), fail.
opcion(2).

obtenerListado2(Total,[H|T]) :- cancion(Id,H , _, _, _), getInvAux, rate(Id, Cont), S is integer((Cont/Total)*10), S > 8, retract(cancion(Id,H , _, _, _)), obtenerListado2(Total, T).
obtenerListado2(_, []).

rate(Id, Cont) :- invaux(_, L), pertenece(Id, L), retract(invaux(_, L)), rate(Id, Cont2), Cont is Cont2 + 1.
rate(_, 0).

pertenece(H, [H|_]).
pertenece(H, [_|T]) :- pertenece(H,T).

getI(Total) :- getInvAux, contarInv(Total).

contarInv(Total) :- retract(invaux(P,Y)), contarInv(Total2), Total is Total2 + 1.
contarInv(0).

getInvAux :- retractall(invaux/2), invitado(P,Y), assert(invaux(P,Y)), fail.
getInvAux.