%cancion(Cod_cancion,Nombre,Artista,Duracion,Genero).
%invitados(Nombre,1[Cod_cancion]n).

:-dynamic cancion/5.
:-dynamic invitados/2.

inicio:-abrirDb,writeln('Ingrese opcion'),
        writeln('1. Listar canciones de Jazz que duran mas de 5 minutos'),
        writeln('2. Listar canciones que le gustan a más del 80% de los invitados'),
        writeln('3. Salir'), read(Op), opcion(Op).

abrirDb:-retractall(cancion/5),retractall(invitados/2),consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f8.txt').

opcion(1):-writeln('Las siguientes canciones de Jazz duran más de 5 minutos: '),listarCanciones, nl, inicio.
opcion(2):-writeln('Las siguientes canciones le gustan a mas del 80% de los invitados: '),cantInvitados(Tot),abrirDb,listaInvitados(List_inv),
           abrirDb,cancionesPopulares(Tot,List_inv,Lista),writeln(Lista),nl, inicio.
opcion(3):-writeln('Bye Bye').


listarCanciones:-retract(cancion(_,Nombre,_,Duracion,jazz)), Duracion > 5, writeln(Nombre),listarCanciones.
listarCanciones:-retract(cancion(_,_,_,_,jazz)),listarCanciones.
listarCanciones.


cantInvitados(Tot):-retract(invitados(_,_)),cantInvitados(Tot_ant),Tot is Tot_ant + 1.
cantInvitados(0).

listaInvitados([H|T]):-retract(invitados(H,_)),listaInvitados(T).
listaInvitados([]).


cancionesPopulares(Tot,List_inv,[Cod|T]):-retract(cancion(Cod,_,_,_,_)),gusta(Cod,List_inv,Cant),Cant/Tot > 0.8,cancionesPopulares(Tot,List_inv,T).
cancionesPopulares(_,_,[]).

gusta(Cod,[H|T],Cant):-invitados(H,Lista),pertenece(Lista,Cod),gusta(Cod,T,Cant_ant),Cant is Cant_ant + 1.
gusta(Cod,[_|T],Cant):-gusta(Cod,T,Cant).
gusta(_,[],0).

pertenece([H|_],H).
pertenece([_|T],H):-pertenece(T,H).
