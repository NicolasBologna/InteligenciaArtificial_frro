inicio:- Lista = [6,8,20,5,45,8,4,13,45,70,60,50,45,023,456,2345], repetido(Lista,Resultado), print(Resultado).


pertenece(X,[X|_]).
pertenece(X,[_|T]):-pertenece(X,T).

repetido([H|T],Resultado) :- pertenece(H,T), Resultado is H.
repetido([_|T],Resultado) :- repetido(T, Resultado).