/*
[IA] Parcial de AD. 15-10-2019 (Práctica)

provincia(id_provincia, nombre_provincia)
localidad(id_localidad, nombre_localidad, id_provincia)
persona(dni_persona, nombre_persona,fecha_nac,salario,id_localidad)
candidato(id_candidato, nombre_candidato)
intencion_de_voto(dni_persona,id_candidato)
La fecha en formato dd/mm/aaaa

1) Lista de las personas nacidas antes del año 1950 de una provincia. (Se leia el nombre de la provincia)

2) Mostrar el salario promedio de las personas con intencion de voto hacia un candidato ingresado en una provincia (Se leia el nombre de la provincia y el nombre del candidato)
*/

:-dynamic(provincia/2).
:-dynamic(localidad/3).
:-dynamic(persona/5).
:-dynamic(candidato/2).
:-dynamic(intencion_de_voto/2).


inicio:- abrir_base, write('ingrese la opcion: '), read(Opc), opcion(Opc).

opcion(1):-  write('ingrese provincia: '), read(Provincia), listarPersonas(Provincia), inicio.

opcion(2):- write('ingrese provincia: '), read(Provincia),write('ingrese candidato: '), read(Candidato),.

opcion(_).

listarPersonas(Provincia):- provincia(IdProvincia, Provincia), recorrerLocalidades(IdProvincia).

recorrerLocalidades(IdProvincia):-localidad(IdLocalidad,_,IdProvincia), retract(localidad(IdLocalidad,_,IdProvincia)), listarNombres(IdLocalidad), recorrerLocalidades(IdProvincia).

listarNombres(IdLocalidad):- persona(Dni,Nombre_persona,FechaNac,_,IdLocalidad), 
retract(persona(Dni,Nombre_persona,FechaNac,_,IdLocalidad)), sub_atom(FechaNac, _, 4, 0, Anio), atom_number(Anio, AnioN), 
AnioN < 1950 ,write(Nombre_persona), listarNombres(IdLocalidad).

listarNombres(_).

abrir_base:- retractall(provincia),retractall(localidad), retractall(persona), retractall(candidato), retractall(intencion_de_voto),consult('C:/Users/Nico/Repos/InteligenciaArtificial_frro/Resolucion finales/IA_Final_AD_2019-10-15.txt').

