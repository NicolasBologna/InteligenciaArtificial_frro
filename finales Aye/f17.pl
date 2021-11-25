:-dynamic (auto/2).
:-dynamic (viaje/2).

inicio:-abrirDb,writeln('Ingrese opcion '),
                writeln('1. Obtener total acumulado de ganancia por cada auto'),
                writeln('2. Ingresar lista para ver que auto tiene al menos un viaje > 300'),
                writeln('3. Salir'), read(Op), opcion(Op).

abrirDb:-retractall(auto(_,_)),retractall(viaje(_,_)) , consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f17.txt').


opcion(1):-calcularTotal,nl, inicio.
opcion(2):-writeln('Ingrese los códigos de los autos sobre los que quiere buscar, para finalizar ingrese []'),leer(L),
           writeln('Los siguientes autos tienen al menos un viaje > 300'),buscar(L), nl, inicio.
opcion(3):-writeln('Bye Bye').


calcularTotal:-auto(Cod,Pat),getTotal(Cod,Tot),retract(auto(Cod,_)),
               write('Auto: '),write(Cod),write(' -- '),write('Patente: '),write(Pat),
               write(' -- '),write('Total de ganancia: '),write(Tot),nl,calcularTotal.
calcularTotal.


getTotal(Cod,Tot):-viaje(Cod,Gan),retract(viaje(Cod,Gan)),getTotal(Cod,Gan_ant),Tot is Gan_ant + Gan.
getTotal(_,0).


leer([H|T]):-read(H),H\=[],leer(T).
leer([]).

buscar([H|T]):-viaje(H,Gan),Gan>300,writeln(H),buscar(T).
buscar([_|T]):-buscar(T).
buscar([]).

