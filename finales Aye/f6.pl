%institutosalud(Id_inst,Nombre_inst,Direccion,Sector,1[Obra_social]n).
%medico(Id_med,Nombre_med,Tipo,1[Id_inst]n).

:-dynamic(institutosalud/5).
:-dynamic(medico/4).

inicio:-abrirDb,writeln('Ingrese opción'),
        writeln('1.Listar código de instituciones para una obra social y un sector'),
        writeln('2.Listar código de instituciones para un médico y obra social'),
        writeln('3.Salir'), read(Op), opcion(Op).

abrirDb:-retractall(institutosalud(_,_,_,_,_)),retractall(medico(_,_,_,_)),
         consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f6.txt').

opcion(1):-writeln('Ingrese obra social: '),read(Ob_soc), writeln('Ingrese sector: '),read(Sec),
           buscarInst(Ob_soc,Sec,Lista), write('Los códigos de las instituciones que coinciden son: '),
           writeln(Lista),nl,inicio.
opcion(1):-writeln('No contamos con informacion registrada'), nl, inicio.
opcion(2):-writeln('Ingrese obra social'),read(Ob_soc),writeln('Ingrese nombre del medico: '),read(Nombre_med),
           medico(_,Nombre_med,_,List_inst), buscarObra(List_inst,Ob_soc,Lista),
           write('Los códigos de las instituciones que coinciden son: '), writeln(Lista),nl,inicio.
opcion(2):-writeln('No contamos con informacion registrada'), nl, inicio.
opcion(3):-writeln('Bye Bye').


%Opcion 1.
buscarInst(Ob_soc,Sec, [Id_inst|T]):-retract(institutosalud(Id_inst,_,_,Sec,Lista_ob)),
                                     pertenece(Lista_ob,Ob_soc),buscarInst(Ob_soc,Sec,T).
buscarInst(_,_, []).


pertenece([H|_],H).
pertenece([_|T],H):-pertenece(T,H).


%Opcion 2.
buscarObra([H|T1],Ob_soc,[H|T2]):-institutosalud(H,_,_,_,List_obras),pertenece(List_obras,Ob_soc),
                                 buscarObra(T1,Ob_soc,T2).
buscarObra([_|T1],Ob_soc,Lista):-buscarObra(T1,Ob_soc,Lista).
buscarObra([],_,[]).


