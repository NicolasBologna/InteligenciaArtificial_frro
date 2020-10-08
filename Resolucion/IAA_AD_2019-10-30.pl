/*  alumno(dni_alumno, nombre_alumno)
    materia(id_materia, nombre_materia,[dnis_alumnos])
    carrera(id_carrera, nombre_carrera, [lista_ids_materias])
    examen_final(dni_alumno, id_materia, nota, anio) 

1- Ingresar un nombre de materia, anio, lista de dnis de alumnos, se devuelvan 2 listas una con los nombres de los aprobados
 para esa materia en ese anio y otra con los no aprobados.

2- Ingresar una lista de ids de materias y devolver una lista con las carreras que tengan todas esas materias.              */

:-dynamic(alumno/2).
:-dynamic(materia/3).
:-dynamic(carrera/3).
:-dynamic(examen_final/4).

menu :- abrir_base, writeln("1 - (Dado un año, una materia y una lista de alumnos, listar aprobados y desaprobados)"),
          writeln("2 - (Dado una lista de materias, listar las carreras que contengan todas esas materias)"),
          writeln("3 - (Salir)"), read(Opc), Opc \= 3, opcion(Opc), menu.
menu :- write("Que tenga un buen dia").

opcion(1) :- writeln("Ingrese un año"), read(Anio), writeln("Ingrese una Materia"), read(Mat), leer(Lista),
             filtrarListas(Anio, Mat, Lista, LA, LNA), writeln("Lista de Alumnos Aprobados:"), writeln(LA),
            writeln("Lista de Alumnos NO Aprobados:"), writeln(LNA).
opcion(2) :- leerMaterias(LM), filtrarMaterias(LM,LS), writeln("Las carreras que contienen todas esas esa materias son: "), writeln(LS).

filtrarMaterias(LM, [NombC|T_LS]) :- carrera(H_LS, NombC, Ms), consulta(LM, Ms), retract(carrera(H_LS, NombC, Ms)), filtrarMaterias(LM, T_LS).
filtrarMaterias(_, []).

consulta([H_LM|T_LM], Ms) :- pertenece(H_LM, Ms), consulta(T_LM, Ms).
consulta([], _).

buscar([H1|T],Listita):- pertenece(H1,Listita), buscar(T,Listita).
buscar([],_).

pertenece(H, [H|_]).
pertenece(H, [_|T]) :- pertenece(H, T).

leerMaterias([H|T]) :- writeln("Ingrese ID de Materia o [] para terminar"), read(H), H\= [], leerMaterias(T).
leerMaterias([]).

abrir_base :- retractall(alumno/2), retractall(materia/3), retractall(carrera/3), retractall(examen_final/3), consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_AD_2019-10-30.txt').

leer([H|T]) :- writeln("Ingrese DNI del Alumno o [] para terminar"), read(H), H \= [], leer(T).
leer([]).

filtrarListas(Anio, Mat, [DNI|T], [DNI|LAT], LNA) :- examen_final(DNI, Mat, Nota, Anio), Nota >= 6, retract(examen_final(DNI, Mat, Nota, Anio)),filtrarListas(Anio, Mat, T, LAT, LNA).
filtrarListas(Anio, Mat, [DNI|T], LA, [DNI|LNAT]) :- examen_final(DNI, Mat, Nota, Anio), Nota < 6, retract(examen_final(DNI, Mat, Nota, Anio)),filtrarListas(Anio, Mat, T, LA, LNAT).
filtrarListas(_, _, [], [], []).