/*
persona(dni,nombre,edad,obraSocial,plan).
obraSocial (obra,plan, medicamento,%cobertura).
1- devolver una lista con los DNI de las personas que tengan más de 65 años y cuyo plan cubra al menos 10 medicamentos al 100%.
2- devolver los datos de aquellas personas que tengan más de una obra social.
*/
:- dynamic(persona/5).
:- dynamic(obraSocial/4).
:- dynamic(auxOS/4).

abrirBase:- retractall(persona/5), retractall(obrasocial/4), consult('D:/Documentos/Prolog/Finales/IA_Final_Practica_2017-08-10.txt').

inicio:- write('Opcion: '), read(O), menu(O).

menu(1):- abrirBase,getPersonas(Lista), listar(Lista).
menu(2):- abrirBase, getPersonasMuchasOS(Lista), listar(Lista).

getPersonas([Dni|T]):-
    retract(persona(Dni,_,Edad,OS,Plan)),
    Edad>65,
    getObrasSociales,
    contarMedicamentos(OS,Plan,Total),
    Total>2, %en realidad, 10
    getPersonas(T).
getPersonas([]).

contarMedicamentos(OS,Plan,Total):-
    retract(auxOS(OS,Plan,_,100)),
    contarMedicamentos(OS,Plan,Ac),
    Total is Ac + 1.
contarMedicamentos(_,_,0).

getPersonasMuchasOS([Dni|T]):-
    persona(Dni,_,_,_,_),
    contarOS(Dni,Cant),
    Cant > 1,
    getPersonasMuchasOS(T).
getPersonasMuchasOS([]).

contarOS(Dni,Cant):-
    retract(persona(Dni,_,_,_,_)),
    contarOS(Dni,Ac),
    Cant is Ac + 1.
contarOS(_,0).

listar([H|T]):- writeln(H),nl,listar(T).
listar([]).

getObrasSociales:-
    retractall(auxOS/4),
    obraSocial(OS,Plan,Med,Porc),
    assert(auxOS(OS,Plan,Med,Porc)),
    fail.
getObrasSociales.
