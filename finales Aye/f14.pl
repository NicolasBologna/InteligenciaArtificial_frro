%medicamentos(Nombre_med, Droga, Presentación, Laboratorio, 1[Síntomas_que_contrarresta]n).
%composición(Nombre_med, Componente, Cantidad).
:- dynamic(medicamentos/5).
:- dynamic(composicion/3).


inicio:-abrirDb, writeln('Ingrese opcion'),
                  writeln('1. Listar medicamentos recomendados para un paciente segun sus sintomas.'),
                  writeln('2. Listar medicamentos segun componentes.'),
                  writeln('3. Salir.'), read(Op), opcion(Op).

abrirDb:-retractall(medicamentos(_,_,_,_,_)), retractall(composicion(_,_,_)),
         consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f14.txt').

opcion(1):-writeln('Ingrese lista de sintomas'), leer(List_sintomas),
           contarSintomas(List_sintomas,Cant), buscarMedic(List_sintomas,Cant,List_med),
           writeln('Lista de medicamentos que cubren el 80% de los sintomas: '), writeln(List_med), nl, inicio.

opcion(2):-writeln('Ingrese componente 1: '), read(C1), writeln('Ingrese cantidad: '), read(Cant1),
           writeln('Ingrese componente 2: '), read(C2), writeln('Ingrese cantidad: '), read(Cant2),
           buscaMedXCompo(C1,Cant1,C2,Cant2,Lista_med),
           writeln('Medicamentos correspondientes: '), writeln(Lista_med), nl, inicio.

opcion(3):-writeln('Bye Bye').

%Generales
leer([H|T]):-read(H), H\=[], leer(T).
leer([]).

pertenece(H,[H|_]).
pertenece(H,[_|T]):-pertenece(H,T).


%Opcion 1.
contarSintomas([_|T],Cant):- contarSintomas(T,Cant_ant), Cant is Cant_ant + 1.
contarSintomas([],0).

buscarMedic(List_sintomas,Cant,[Nombre_med|T]):-retract(medicamentos(Nombre_med,_,_,_,List_sint_med)),
                                                cantCoincidencias(List_sintomas,List_sint_med,Cant_coin),
                                                Cant_coin \= 0, Porc is  Cant_coin/Cant, Porc >= 0.8,
                                                buscarMedic(List_sintomas,Cant,T).
buscarMedic(_,_,[]).

cantCoincidencias([H|T],List_sint_med,Cant_coin):-pertenece(H,List_sint_med),
                                                  cantCoincidencias(T,List_sint_med,Cant_coin_ant),
                                                  Cant_coin is Cant_coin_ant +1.
cantCoincidencias([_|T],List_sint_med,Cant_coin):-cantCoincidencias(T,List_sint_med,Cant_coin).
cantCoincidencias([],_,0).


%Opcion 2.
buscaMedXCompo(C1,Cant1,C2,Cant2,[Nom_med|T]):- retract(composicion(Nom_med,C1,Cant1)),retract(composicion(Nom_med,C2,Cant2)),
                                                buscaMedXCompo(C1,Cant1,C2,Cant2,T).
buscaMedXCompo(_,_,_,_,[]).
