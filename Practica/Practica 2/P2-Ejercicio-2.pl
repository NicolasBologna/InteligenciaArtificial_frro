inicio:- write('Ingrese una lista de elementos: '), leer(Lista), mostrar(Lista).
 
leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).

mostrar([X|Y]):- write('cabeza: '),writeln(X), write('cola: '),writeln(Y).

