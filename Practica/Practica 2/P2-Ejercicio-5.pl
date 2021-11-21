inicio:- Lista = [1,2,3,4,5,6,7,8], buscarUltimo(Lista).

buscarUltimo([X|[]]):-write(X).
buscarUltimo([_|Cola]):- buscarUltimo(Cola).