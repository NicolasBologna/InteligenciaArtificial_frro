%ver como hacer para agregar la validacion de no meter repetidos [6,8,8,4,45,50,45,45,40]

inicio:- Lista = [6,8,8,4,45,50,45,40], repetidos(Lista,Resultado), print(Resultado).


pertenece(X,[X|_]).
pertenece(X,[_|T]):-pertenece(X,T).

repetidos([],[]).
repetidos([H|T],[H|Cola]) :- pertenece(H, T), repetidos(T, Cola).
repetidos([_|T], ListaRepetidos) :-  repetidos(T,ListaRepetidos).
