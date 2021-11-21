inicio:- Lista = [1,2,3,4,5,6,7,8], sumatoria(Lista, Resultado), writeln(Resultado).

sumatoria([], 0).
sumatoria([Cabeza|Cola], Resultado):- sumatoria(Cola, Res), Resultado is Cabeza + Res.