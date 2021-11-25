%alumno(Dni,Nombre).
%materia(Cod_materia,Nombre_materia,1[Dni_alumno]n).
%carrera(Cod_carrera,Nombre_carrera,1[Cod_materia]n).
%examen_final(Dni_alumno,Cod_materia,Nota,Anio).

:-dynamic (alumno/2).
:-dynamic (materia/3).
:-dynamic (carrera/3).
:-dynamic (examen_final/4).


%Generales.
abrirDb:- retractall(alumno/2), retractall(materia/3), retractall(carrera/3),
          retractall(examen_final/4), consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f1.txt').

leer([H|T]):- read(H), H\=[], leer(T).
leer([]).

pertenece([H|_],H).
pertenece([_|T],H):- pertenece(T,H).


%Menu.
inicio:-abrirDb, writeln('Ingrese opcion'),
                 writeln('1. Indicar alumnos que aprobaron y desaprobaron una materia en un año'),
                 writeln('2. Listar carreras que contengan todas las materias ingresadas'),
                 writeln('3. Salir'), read(Op), opcion(Op).

opcion(1):-writeln('Ingrese materia:'), read(Mat), writeln('Ingrese año:'), read(Anio),
           writeln('Ingrese lista de Dni de alumnos:'), leer(List_alumnos),
           resultadoExamen(Mat,Anio,List_alumnos,List_aprobados,List_desaprobados),
           write('Los alumnos aprobados son: '), writeln(List_aprobados),
           write('Los alumnos desaprobados son: '), writeln(List_desaprobados), nl, inicio.

opcion(2):-writeln('Ingrese lista de Códigos de Materias'), leer(List_mat),
           validarMaterias(List_mat,List_Car),
           write('Las carreras que cuentan con todas esas materias son: '),writeln(List_Car), nl, inicio.

opcion(3):-writeln('Bye Bye').


%Opcion 1.
resultadoExamen(Mat,Anio,[Dni|T1],[Dni|T2],List_desaprobados):-examen_final(Dni,Mat,Nota,Anio), Nota >= 6,
                                                            resultadoExamen(Mat,Anio,T1,T2,List_desaprobados).
resultadoExamen(Mat,Anio,[Dni|T1],List_aprobados,[Dni|T2]):-examen_final(Dni,Mat,_,Anio),
                                                            resultadoExamen(Mat,Anio,T1,List_aprobados,T2).
resultadoExamen(_,_,[],[],[]).


%Opcion 2.
validarMaterias(List_mat,[Nombre_carrera|T]):-retract(carrera(_,Nombre_carrera,List_mat_car)),
                                              comparaListas(List_mat,List_mat_car),
                                              validarMaterias(List_mat,T).
validarMaterias(_,[]).


comparaListas([Cod_materia|T],List_mat_car):-pertenece(List_mat_car,Cod_materia),
                                             comparaListas(T,List_mat_car).
comparaListas([],_).
