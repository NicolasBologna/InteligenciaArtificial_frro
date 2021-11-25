/*
 * publicacion(idPub,descripcion,IdUsuarioPub,[Lista ID Usuarios que dan Like]).
usuario(id,nombre,edad).
1. Listar las publicaciones que tienen más de 50 likes.
2. Ingresar un id de usuario, y decir si el 80% de sus publicaciones no tienen ningun like.
 *
 */
:-dynamic(publicacion/4).
:-dynamic(usuario/3).

abrirBase:-
    retractall(publicacion/4),
    retractall(usuario/3),
    consult('D:/Documentos/Prolog/Finales/IA_Final_Practica_2016-11-24_Publicaciones.txt').

inicio:-
    write('1- Publicaciones con mas de 50 likes 2- Ver que tan fracasado es un usuario Ingrese: '),
    read(O),
    menu(O).

menu(1):-
    abrirBase,
    getPublicaciones.

menu(2):-
    abrirBase,
    write('Ingrese usuario: '),
    read(U),
    usuario(U,_,_),
    getFracaso(U,CantCero),
    abrirBase,
    contarPub(U,Total),
    mostrarFracaso(CantCero,Total).
menu(2):-write('Usuario no encontrado.').

getPublicaciones:-
    retract(publicacion(IDPub,_,_,Likes)),
    contar(Likes,Cant),
    Cant>7,
    writeln(IDPub),
    getPublicaciones.
getPublicaciones.

getFracaso(U,CantCero):-
    retract(publicacion(_,_,U,Likes)),
    contar(Likes,Cant),
    Cant=0,
    getFracaso(U,AcumC),
    CantCero is AcumC+1.
getFracaso(_,0).

contarPub(U,Cant):-
    retract(publicacion(_,_,U,_)),
    contarPub(U,Ac),
    Cant is Ac+1.
contarPub(_,0).


contar([_|T],Cant):-
    contar(T,Acum),
    Cant is Acum+1.
contar([],0).

mostrarFracaso(_,0):-
    writeln('No tiene publicaciones. Fracaso maaaal').

mostrarFracaso(CantCero,Total):-
    P is CantCero/Total,
    P>=0.8,
    writeln('Frakso').
mostrarFracaso(_,_):-
    writeln('Alto farandula, mas del 80% con likes').


