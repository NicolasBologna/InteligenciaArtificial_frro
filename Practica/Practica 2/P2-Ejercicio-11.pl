/*inicio:- L = [11,2,13,4,53,6,8,20], mayor(L,N), print(N).

%mayor([H], H).
%mayor([H|T], Mayor) :- M is H, mayor(T, A), A >= M, Mayor is A.


mayor([N],N).

mayor([H|T], N):- mayor(T,N), H < N.
mayor([H|T], H):- mayor(T,Y), H >= Y.*/


inicio :-writeln("Ingrese los números de la lista:"), leer(Lista), writeln(Lista), mayor(Lista, Mayor), writeln("El numero mayor es: "), writeln(Mayor).

leer([H|T]) :- read(H), H\= [], leer(T).
leer([]).

/*mayor([H|T], Mayor) :- Mayor .
mayor([H|T], Mayor) :- Mayor .
mayor([H|T], Mayor) :- M is H, mayor(T, A), A >= M, Mayor is A.*/

mayor([H|[]], H).
mayor([H|T], Mayor) :- mayor(T, A), A >= H, Mayor is A.
