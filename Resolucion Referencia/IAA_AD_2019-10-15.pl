/* 
provincia(id_provincia, nombre_provincia)
localidad(id_localidad, nombre_localidad, id_provincia)
persona(dni_persona, nombre_persona,fecha_nac,salario,id_localidad)
candidato(id_candidato, nombre_candidato)
intencion_de_voto(dni_persona,id_candidato)
La fecha en formato dd/mm/aaaa

OJOOOOOO DA ERROR CUANDO TRATA DE COMPARAR LA FECHA CON LA FECHA DE SUB_ATOM pero es un prog de mierda Y SE TOMARIA BIEN para el Final */

:- dynamic(provincia/2).
:- dynamic(localidad/3).
:- dynamic(persona/5).
:- dynamic(candidato/2).
:- dynamic(intencion_de_voto/2).

inicio  :- abrir_base, writeln("1 - (Listar personas nacidas antes de 1950 en Sta Fe)"),
           writeln("2 - (Dado un candidato, mostrar salario promedio de las personas con intencion de voto hacia el candidato ingresado en Sta Fe)"),
           writeln("3 - (Salir)"), read(Opc), Opc \= 3, opcion(Opc).
inicio :- write("Que tenga un buen dia!").

opcion(1) :- provincia(Id_prov, santafe), listadoXfecha(Id_prov, Lista), writeln(Lista), inicio.

opcion(2) :- writeln("Ingrese candidato"), read(NombCand), candidato(IdCand, NombCand), prom(IdCand, Cant, Suma), Cant \= 0, Prom is Suma/Cant,
             write("Salario promedio del Votante de "), write(NombCand), write(" es de "), writeln(Prom), inicio.
opcion(2) :- writeln("El Candidato inexistente"), inicio.

prom(IdCand, Cant, Suma) :- intencion_de_voto(D, IdCand), provincia(IdP, santafe), localidad(IdLoc, _, IdP), retract(persona(D, _, _, Salario, IdLoc)),
                            prom(IdCand, Cant2, Suma2), Cant is Cant2 + 1, Suma is Suma2 + Salario.
prom(_, 0, 0).

listadoXfecha(Id_prov, [Dni|T]) :- localidad(Id_loc, _, Id_prov), retract(persona(Dni, _, Fnac, _, Id_loc)), sub_atom(Fnac, _, 4, 0, Fecha), 
                                   Fecha < 1950, listadoXfecha(Id_prov, T).
listadoXfecha(_, []).


abrir_base:- consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_AD_2019-10-15.txt').



