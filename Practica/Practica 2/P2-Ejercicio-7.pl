inicio:- Lista = [1,2,3,4,5,6,7,8], contarElementos(Lista, Cantidad), writeln(Cantidad).

contarElementos([], 0).
contarElementos([_|Cola], Cantidad):- contarElementos(Cola, Cant), Cantidad is Cant + 1.