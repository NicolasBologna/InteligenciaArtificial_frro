inicio:- Lista = [6,8,8,4,45,50,45,8,40], Elemento = 8,repetidos(Lista,Elemento,Resultado), print(Resultado).


repetidos([],_, 0).
repetidos([H|T],Elemento,Resultado) :- H == Elemento, repetidos(T,Elemento,Res), Resultado is Res + 1.
repetidos([_|T],Elemento,Resultado) :-  repetidos(T,Elemento,Resultado).
