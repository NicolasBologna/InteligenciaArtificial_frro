:-dynamic(vacuna/3).
:-dynamic (enfermedad/3).
:-dynamic (sintoma/2).


abrirDb:- retractall(vacuna/3), retractall(enfermedad/3), retractall(sintoma/2),
         consult('C:/Users/54346/Documents/Facultad/Facultad2021/InteligenciaArtificial/examen_parcial.txt').

inicio:- abrirDb,write('ingrese opcion 1- enf no curadas por ninguna vacuna 2-Vacunas con mas de 5 enf  '),read(Op),opcion(Op),inicio.

opcion(1):-validar_enf(Enfermedades),write('las enfermedades son: '),writeln(Enfermedades).

validar_enf([Nombre|T]):-enfermedad(IdE,Nombre,_),
                          vacuna(_,_,ListaE),
                       not(pertenece(ListaE,IdE)),
                       retract(enfermedad(IdE,Nombre,_)),
                       validar_enf(T).
%validar_enf([_|T]):- validar_enf(T).
validar_enf([]).


pertenece([H|_],H).
pertenece([_|T],N):-pertenece(T,N).
