/*                                                              Final O.S. [22/02/2018]
institutoSalud(Codinstitu,Nombre,Direccion,Telefono,Sector,[Obras Sociales]).
Medico(Matricula, Nombre, Especialidad, [CodInstitutos]).

Sector podía ser privado o publico
1- Devolver una lista [] con los códigos de instituciones que coincidan con la obra social y con el sector, ambos ingresados como dato de entrada.
2- Devolver una lista [] con los códigos de instituciones en las que atiende un médico y según una obra social, también estos dos datos se ingresaban como dato.   */
:-dynamic(institutosalud/6).
:-dynamic(medico/4).

menu :- writeln("1 - (Listar Cod. de Inst. que coinciden con una OS y un sector)"),
        writeln("2 - (Listar Cod. de Inst. en las que atienda un medico a y una OS a ingresar)"),
        writeln("3 - (Salir)"), read(Opc), Opc \= 3, abrir_base, opcion(Opc), menu.
menu :- writeln("Vas aprobar!!!").

opcion(1) :- writeln("Ingrese una Obra Social"), read(OS),
             writeln("Ingrese un Sector (Publico o Privado)"), read(Sector),
             consulta(OS, Sector, Lista), write("Las instituciones que coinciden son: "), writeln(Lista).

opcion(2) :- writeln("Ingrese un Medico"), read(M),
             writeln("Ingrese una Obra Social"), read(OS),
             consulta2(M, OS, Lista), write("Las instituciones son: "), writeln(Lista).

consulta(OS, Sector, [H|T]) :- retract(institutosalud(H, _, _, _, Sector, LOS)), pertenece(OS, LOS), consulta(OS, Sector, T).
consulta(_, _, []).

consulta2(M, OS, [H|T]) :- retract(institutosalud(H, _, _, _, _, LOS)), pertenece(OS, LOS),
                           medico(M, _, _, LCI), pertenece(H, LCI), consulta2(M, OS, T).
consulta2(_, _, []).

pertenece(X, [X|_]).
pertenece(X, [_|Y]) :- pertenece(X, Y).

abrir_base :- retractall(institutosalud/6),
              retractall(medico/4),
              consult('C:/Users/Agus/Desktop/Inteligencia Artificial/Guada Info/Prolog/Finales_Agu/BC/BC_IAA_Final_2018-02-22.txt').