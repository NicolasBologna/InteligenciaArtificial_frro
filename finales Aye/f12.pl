%camion(cod_camion, marca, modelo, tipo_mma, peso_vacio, tipo1, tipo2, tipo3)
%conductor(cod_conductor, apellido_nombre, edad, ciudad_natal, 1[cod_camion]n)

:-dynamic (camion/8).
:-dynamic (conductor/5).

abrirDb:-retractall(camion(_,_,_,_,_,_,_,_)), retractall(conductor(_,_,_,_,_)),
         consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f12.txt').

inicio:-abrirDb,writeln('Ingrese opcion'),
                writeln('1. Consultar camiones para una marca y modelo: '),
                writeln('2. Consultar conductores no habilitados a conducir un camion'),
                writeln('3. Salir'), read(Op), opcion(Op).

opcion(1):-writeln('Ingrese lista con código de camiones: '), leer(List_camion),writeln('Ingrese marca: '),read(Mar),
           writeln('Ingrese modelo: '),read(Mod),buscarCamiones(List_camion,Mar,Mod,Lista),
           writeln('Los camiones que corresponden a la marca y modelo ingresado son: '),write(Lista),nl, inicio.
opcion(2):-writeln('Ingrese lista con código de conductores: '), leer(List_cond),writeln('Ingrese camion: '),read(Cod_cam),
           buscarConductores(List_cond,Cod_cam,Lista),
           writeln('Los conductores que no están habilitados a conducir el camion son: ' ),write(Lista), nl, inicio.
opcion(3):-writeln('Bye Bye').

%General
leer([H|T]):-read(H),H\=[],leer(T).
leer([]).

pertenece([H|_],H).
pertenece([_|T],H):-pertenece(T,H).

%Opcion 1
buscarCamiones([Cod_camion|T1],Mar,Mod,[Cod_camion|T2]):-camion(Cod_camion,Mar,Mod,_,_,_,_,_),
                                                         buscarCamiones(T1,Mar,Mod,T2).
buscarCamiones([_|T1],Mar,Mod,Lista):-buscarCamiones(T1,Mar,Mod,Lista).
buscarCamiones([],_,_,[]).


%Opcion 2
buscarConductores([Cod_conductor|T1],Cod_cam,[Cod_conductor|T2]):-conductor(Cod_conductor,_,_,_,List_camion),
                                                                  not(pertenece(List_camion,Cod_cam)),
                                                                  buscarConductores(T1,Cod_cam,T2).
buscarConductores([_|T1],Cod_cam,Lista):-buscarConductores(T1,Cod_cam,Lista).
buscarConductores([],_,[]).
