inicio:- L = [1,2,3,4,5,6,7,8],  promedio(L,S,C), Promedio is S/C, writeln(Promedio).

promedio([], 0, 0).
promedio([Cabeza|Cola], Sumatoria, Contador):- promedio(Cola, Sum, Cont), Sumatoria is Cabeza + Sum, Contador is Cont + 1.