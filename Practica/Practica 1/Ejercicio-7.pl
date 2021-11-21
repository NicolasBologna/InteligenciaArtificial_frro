menu:-  writeln('¿Que opeacion desea realizar?'),
        writeln('1 - Suma'),
        writeln('2 - Resta'), 
        writeln('3 - Multiplicacion'), 
        writeln('4 - Division'), 
        writeln('5 - Salir'), 
        read(Opc), 
        Opc < 5, 
        writeln('Ingrese el primer numero: '),read(N1),
        writeln('Ingrese el segundo numero: '),read(N2), 
        opcion(Opc, N1,N2),
        menu.
menu:- writeln("Adios").

opcion(1,N1,N2) :- Suma is N1+N2, writeln(Suma).
opcion(2,N1,N2) :- Suma is N1-N2, writeln(Suma).
opcion(3,N1,N2) :- Suma is N1*N2, writeln(Suma).
opcion(4,N1,N2) :- Suma is N1/N2, writeln(Suma).
