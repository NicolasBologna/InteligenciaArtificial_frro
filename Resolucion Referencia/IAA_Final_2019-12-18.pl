/*                                         [Final IA 18/12/2019] - Inteligencia Artificial - Docentes Colegio
Práctica:
docente(dni,nombre,edad,telefono,direccion,ciudad).
colegio(nombreColegio,direccion,ciudad).
col_doc(nombreColegio,dni,[listaMaterias]).
Un docente podía trabajar en distintos colegios y dar diferentes materias según el colegio.
1) Listar todos los docentes que trabajen en al menos 2 colegios diferentes de la ciudad de Rosario.
2) Ingresar una lista de docentes y una lista de colegios y devolver una tercer lista con los docentes que pertenezcan a los colegios ingresados anteriormente. */
:-dynamic(docente/6).
:-dynamic(colegio/3).
:-dynamic(col_doc/3).

menu:- writeln("1 - (Listar todos los docentes que trabajen en al menos 2 colegios diferentes de la ciudad de Rosario)"),
       writeln("2 - (Dada una lista de Docentes y una lista de Colegios, listar los docentes que pertenezcan a los colegios ingresados)"),
       writeln("3 - (Salir)"), read(Opc), Opc \= 3, opcion(Opc), menu.
menu :- write("Vas aprobar!!!").

opcion(1) :- abrir_base, consulta(Lista), write("Los Docentes son: "), writeln(Lista).

opcion(2) :- abrir_base,writeln("Ingrese listado de Docentes"), leer(LD, "Docente"),
             writeln("Ingrese listado de Colegios"), leer(LC, "Colegio"),
             consulta2(LD, LC, S), writeln(S).

consulta([DNI|T]) :- retract(col_doc(NC1, DNI, _)), colegio(NC1, _, rosario),
                     retract(col_doc(NC2, DNI, _)), colegio(NC2, _, rosario),
                      consulta(T).
consulta([]).

consulta2([HD|TD], ListC, [HD|T]) :- retract(col_doc(NombC, HD, _)), pertenece(NombC, ListC), consulta2(TD, ListC, T).
consulta2([_|TD], L, T) :- consulta2(TD, L, T).
consulta2([], _, []).

pertenece(X, [X|_]).
pertenece(X, [_|T]) :- pertenece(X, T).

leer([H|T], Label) :- write("Ingrese "), write(Label), writeln(" o [] para terminar"), read(H), H \= [],  leer(T, Label).
leer([], _).

abrir_base :- retractall(docente/6), retractall(colegio/3), retractall(col_doc/3),
              consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_Final_2019-12-18.txt').