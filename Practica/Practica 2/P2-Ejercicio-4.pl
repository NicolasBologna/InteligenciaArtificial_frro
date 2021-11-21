inicio:- Lista = [1,primero,segundo,3,2,1,4,5,3], mostrarNelementos(Lista, 5).


mostrarNelementos([_|[Y|Z]], Contador):- write('primer elemento: '),writeln(Y) , mostrarCabeceras(Z,Contador).
mostrarCabeceras([_|_],1).
mostrarCabeceras([Cabeza|Cola], Contador):- write('elemento: '),writeln(Cabeza),Contador2 is Contador - 1, mostrarCabeceras(Cola, Contador2).


