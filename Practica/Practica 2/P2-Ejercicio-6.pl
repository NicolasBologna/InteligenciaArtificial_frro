inicio:- Lista = [1,2,3,4,5,6,7,8], diferenciaPyU(Lista).

diferenciaPyU([H|T]):- buscarUltimo([H|T], Ultimo), Resta is H-Ultimo, writeln(Resta).

buscarUltimo([X|[]], Ultimo):- Ultimo = X.
buscarUltimo([_|Cola], Ultimo):- buscarUltimo(Cola, Ultimo).




