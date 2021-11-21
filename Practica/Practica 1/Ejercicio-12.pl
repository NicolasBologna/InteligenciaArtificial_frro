inicio() :- write("Ingrese un numero o e para salir: "), 
            read(X), nl,
            X\='e',
            X>=0,
            sumatoria(X,Resultado),
            write('La sumatoria es: '), write(Resultado), nl. 


sumatoria(0,0). % por que no anda el (0,0)
sumatoria(N,F) :- Ant is N - 1, sumatoria(Ant,FA), F is FA+N.