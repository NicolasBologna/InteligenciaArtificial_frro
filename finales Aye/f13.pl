%docente(dni,nombre,edad,telefono,direccion,ciudad).
%colegio(nombreColegio,direccion,ciudad).
%colegio_docentes(nombreColegio,dni,[listaMaterias]).

:-dynamic (docente/6).
:-dynamic (colegio/3).
:-dynamic (colegio_docentes/3).


inicio:-abrirDb,writeln('Ingrese opción'),
                writeln('1. Listar docente que trabajan en al menos 2 colegios rosarinos'),
                writeln('2. Determinar que docentes pertenecen a los colegios ingresados'),
                writeln('3. Salir'),read(Op),opcion(Op).

opcion(1):-buscarDocentes, nl, inicio.
opcion(2):-writeln('Ingrese una lista de docentes: '),leer(List_doc),
           writeln('Ingrese una lista de colegios'),leer(List_cole),
           determinarPertenencia(List_doc,List_cole,Lista),
           writeln('Los siguientes docentes de la lista pertenecen a los colegios ingresados: '),
           write(Lista), nl, inicio.
opcion(3):-writeln('Bye Bye').


%General.
abrirDb:-retractall(docente/6),retractall(colegio/3),retractall(colegio_docentes/3),
         consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f13.txt').

leer([H|T]):-read(H),H\=[],leer(T).
leer([]).

pertenece([H|_],H).
pertenece([_|T],H):-pertenece(T,H).


%Opcion 1.
buscarDocentes:-retract(docente(Dni,Nombre,_,_,_,_)),
                retract(colegio_docentes(Nom_cole1,Dni,_)), colegio(Nom_cole1,_,'Rosario'),
                retract(colegio_docentes(Nom_cole2,Dni,_)), colegio(Nom_cole2,_,'Rosario'),
                writeln(Nombre),buscarDocentes.
buscarDocentes.


%Opción 2
determinarPertenencia([Nom_doc|T1],List_cole,[Nom_doc|T2]):-docente(Dni,Nom_doc,_,_,_,_),
                                                            retract(colegio_docentes(Nom_cole,Dni,_)),
                                                            pertenece(List_cole,Nom_cole),
                                                            determinarPertenencia(T1,List_cole,T2).
determinarPertenencia([_|T1],List_cole,Lista):-determinarPertenencia(T1,List_cole,Lista).
determinarPertenencia([],_,[]).
