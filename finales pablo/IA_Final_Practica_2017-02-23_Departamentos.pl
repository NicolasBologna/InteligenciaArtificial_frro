/*
 * [Final IA 23/02/2017]
Era muy parecido al final que tomo el 10/03/2016
edificio(nombre, dirección, localidad).
departamento(nombreEdificio, piso, nro, precio, estado, [Código de características])
característica (código, descripción).
Un departamento se identificaba por nombre de edificio, piso y nro.
Estado podía ser libre u ocupado.
Te pedía, ingresar las características (códigos), localidad, y un rango de precios (precio desde y precio hasta), y luego listar todos los departamentos disponibles y lista:
Nombre del departamento.
Dirección.
Piso
Nro
Descripción de las características.
 *
 */

:-dynamic(edificio/3).
:-dynamic(departamento/6).
:-dynamic(caracteristica/2).


inicio:-
    abrirBase,
    writeln('Ingrese caracteristicas: '),
    leer(Carac),
    writeln('Ingrese localidad: '),
    read(L),
    writeln('Ingrese precio min: '),
    read(Min),
    writeln('Ingrese precio max: '),
    read(Max),
    getDeptos(Carac,L,Min,Max).

abrirBase:-
    retractall(edificio/3),
    retractall(departamento/6),
    retractall(caracteristica/2),
    consult('D:/Documentos/Prolog/Finales/IA_Final_Practica_2017-02-23.txt').

getDeptos(C,L,Min,Max):-
    retract(edificio(Edificio,Dire,L)),
    retract(departamento(Edificio,Piso,Nro,Precio,libre,Carac)),
    Precio>=Min,
    Precio<Max,
    posee(C,Carac),
    writeln(Edificio),
    writeln(Dire),
    writeln(Piso),
    writeln(Nro),
    getDeptos(C,L,Min,Max).
getDeptos(_,_,_,_).

posee([H|T],Carac):-
    pertenece(H,Carac),
    posee(T,Carac).
posee([],_).

pertenece(X,[X|_]).
pertenece(X,[_|T]):- pertenece(X,T).

leer([H|T]):- read(H), H\=[], leer(T).
leer([]).

