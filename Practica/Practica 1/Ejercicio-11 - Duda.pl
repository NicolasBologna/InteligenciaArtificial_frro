inicio() :- write("Ingrese un numero o e para salir: "), 
            read(X), nl,
            X\='e',
            X>=0, 15>=X,
            factorial(X,A),
            write('El factorial es: '), write(A), nl,

            X is 0, A is 0, %arranca a hacer factorial con negativos.
            inicio(). 


factorial(0,1).
factorial(N,F) :- Ant is N - 1, factorial(Ant,FA), F is N*FA.