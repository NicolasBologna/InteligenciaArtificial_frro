%ninio(Nombre,Edad,1[Vacuna_aplicada]n).
%vacuna(Vacuna,1[Enfermedad_que_combate]n).
%vacuna_aplicacion(EdadDesde,EdadHasta,1[Vacuna_a_aplicar]n).

:-dynamic(ninio/3).
:-dynamic(vacuna/2).
:-dynamic(vacuna_aplicacion/3).

%General
abrirBD:- retractall(ninio/3), retractall(vacuna/2), retractall(vacuna_aplicacion/3),
          consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f10.txt').

pertenece([H|_],H).
pertenece([_|T],H):- pertenece(T,H).


%Menu
inicio:-abrirBD,writeln('Ingrese opcion'),
                writeln('1. Vacunas que le faltan aplicar a un niño'),
                writeln('2. Cantidad de Vacunas que curan una enfermedad'),
                writeln('3. Salir'), read(Op),opcion(Op).

opcion(1):-writeln('Ingrese niño:'), read(Nombre),vacunasFaltantes(Nombre,Lista),
           writeln('Vacunas que le faltan aplicar: '), write(Lista), nl, inicio.
opcion(2):-writeln('Ingrese enfermedad: '), read(Enfermedad), contarVacunas(Enfermedad, Cant),
           writeln('La cantidad de vacunas que curan la enfermedad es: '), write(Cant), nl, inicio.
opcion(3):-writeln('Bye Bye').


%Opcion1
vacunasFaltantes(Nombre,Lista):- ninio(Nombre,Edad,List_vac_aplicadas),
                                 vacuna_aplicacion(Desde,Hasta,List_vac_obli),
                                 Desde =< Edad, Hasta >= Edad,
                                 comparaVacunas(List_vac_aplicadas,List_vac_obli,Lista).

comparaVacunas(List_vac_aplicadas,[Vacuna|T1],[Vacuna|T2]):- not(pertenece(List_vac_aplicadas,Vacuna)),
                                                             comparaVacunas(List_vac_aplicadas,T1,T2).
comparaVacunas(List_vac_aplicadas,[_|T1],Lista):- comparaVacunas(List_vac_aplicadas,T1,Lista).
comparaVacunas(_,[],[]).

%Opcion2
contarVacunas(Enfermedad, Cant):-retract(vacuna(_,List_enf)),pertenece(List_enf,Enfermedad),
                                contarVacunas(Enfermedad,Cant_ant), Cant is Cant_ant + 1.
contarVacunas(_,0).
