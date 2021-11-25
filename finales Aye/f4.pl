%usuario(idUsuario, edad, estado, ciudad, 1[idAmigo]n).
%comentarios(idComentario,idUsuario, comentario).
%provincia(idProvincia, 1[ciudad]n).

:-dynamic (usuario/5).
:-dynamic (comentarios/3).
:-dynamic (provincia/2).

%Generales
abrirDb:-retractall(usuario/5),retractall(comentarios/3),retractall(provincia/2),
         consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f4.txt').

pertenece([H|_],H).
pertenece([_|T],H):-pertenece(T,H).


%Menu
inicio:-abrirDb, writeln('Ingrese opcion'),
                 writeln('1. Cantidad de usuarios activos con al menos 2 comentario'),
                 writeln('2. Lista de potenciales amigos para un usuario'),
                 writeln('3. Salir'), read(Op),opcion(Op).

opcion(1):-buscarUsuarios(Cant), write('Los usuarios son: '), writeln(Cant), nl, inicio.

opcion(2):-writeln('Ingrese usuario: '),read(User),usuario(User,_,_,Ciudad,_),
           buscarAmigos(User, Ciudad, Lista), write('Los potenciales amigos son'), writeln(Lista), nl, inicio.

opcion(3):-writeln('Bye Bye').


%Opcion 1
buscarUsuarios(Cant):-retract(usuario(IdUsuario,_,activo,_,_)),
                      contarComentarios(IdUsuario, Tot_com), Tot_com >= 2,
                      buscarUsuarios(Cant_ant), Cant is Cant_ant + 1.
buscarUsuarios(0).


contarComentarios(IdUsuario, Tot_com):-retract(comentarios(_,IdUsuario,_)),
                                       contarComentarios(IdUsuario, Tot_com_ant),
                                       Tot_com is Tot_com_ant + 1.
contarComentarios(_,0).


%Opcion 2
buscarAmigos(User, Ciudad, [IdUsuario|T]):-retract(usuario(IdUsuario,_,_,Ciudad,List_ami)), IdUsuario \= User,
                                           not(pertenece(List_ami,User)),not(comentarios(_,IdUsuario,_)),
                                           buscarAmigos(User, Ciudad, T).
buscarAmigos(_,_,[]).
