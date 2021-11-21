inicio:- L = [1,2,3,4,5,6,7,8], N = 33, estaEnLaLista(L,N).

estaEnLaLista([X|_], X):-writeln('Petenece').
estaEnLaLista([], N):- writeln('No pertenece').
estaEnLaLista([_|Cola], N):- estaEnLaLista(Cola, N).