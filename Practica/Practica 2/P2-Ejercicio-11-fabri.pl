
iniciar :-writeln("Ingrese los números de la lista:"), leer(Lista), writeln(Lista), mayor(Lista, Mayor), writeln("El numero mayor es: "), writeln(Mayor).

leer([H|T]) :- read(H), H\= [], leer(T).
leer([]).

mayor([H], H).
mayor([H|T], Mayor) :- M is H, mayor(T, A), A >= M, Mayor is A.