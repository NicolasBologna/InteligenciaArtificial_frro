inicio :- writeln('Ingrese una cadena: '), read(String), pasar_a_lista(String, Lista), repetidos(Lista, ListaRepetidos), writeln(ListaRepetidos),contar_cada_repetido(Lista, ListaRepetidos).

pasar_a_lista('',[]).
pasar_a_lista(C, [H|T]) :- sub_atom(C, 0, 1, _, H), sub_atom(C, 1, _, 0, Sub), pasar_a_lista(Sub, T).

pertenece([X| _], X).
pertenece([_| T], X) :- pertenece(T, X).

repetidos([H| T], [H| TRepetidos]) :- pertenece(T, H), repetidos(T, TRepetidos), not(pertenece(TRepetidos, H)).
repetidos([_| T], Repetidos) :- repetidos(T, Repetidos).
repetidos([], []).

cant_repetidos([],_, 0).
cant_repetidos([H|T],Elemento,Resultado) :- H == Elemento, cant_repetidos(T,Elemento,Res), Resultado is Res + 1.
cant_repetidos([_|T],Elemento,Resultado) :-  cant_repetidos(T,Elemento,Resultado).

contar_cada_repetido(_, []).
contar_cada_repetido(Lista, [H|T]) :-  cant_repetidos(Lista, H, Resultado), write("El caracter "), write(H), write(" aparece "), write(Resultado), writeln(" veces."), contar_cada_repetido(Lista, T).


