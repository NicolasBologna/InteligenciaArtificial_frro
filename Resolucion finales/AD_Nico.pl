:-dynamic(persona/5).
:-dynamic(intencion_de_voto/2).
:-dynamic(candidato/2).
:-dynamic(localidad/3).
:-dynamic(provincia/2).


abrir_base:- retractall(persona), retractall(intencion_de_voto), retractall(candidato), retractall(localidad), retractall(provincia), consult('txt').

inicio:- abrir_base,write('ingrese opcion:'), read(Opc), menu(Opc).

menu(1):- write('ingrese provincia: '), read(Provincia), provincia(Id,Provincia), recorrerProv(Id,Lista),write(Lista), inicio.
