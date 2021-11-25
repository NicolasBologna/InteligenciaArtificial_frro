%persona(Dni,Nombre,Edad,ObraSocial,Plan).
%obraSocial(Obra,Plan, Medicamento, Porcentaje_Cobertura).

:-dynamic(persona/5).
:-dynamic(obraSocial/4).

abrirDb:-retractall(persona(_,_,_,_,_)),retractall(obraSocial(_,_,_,_)),
         consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f15.txt').

inicio:-abrirDb, writeln('Ingrese opcion'),
                 writeln('1.Lista con los DNI de las personas > 65 años, cuyo plan cubra al menos 2 medicamentos al 100%'),
                 writeln('2.Datos de personas con más de una obra social'),
                 writeln('3.Salir'), read(Op),opcion(Op).

opcion(1):-buscarPersona(List_persona), writeln('Listado con el dni de las personas correspondientes: '),
           abrirDb,buscarMedicamentos(List_persona), nl, inicio.
opcion(2):-buscarPersona2(List_persona),writeln('Listado de las personas con mas de 2 obras sociales'),
           abrirDb,imprimir(List_persona), nl, inicio.
opcion(3):-writeln('Bye Bye').


%Opcion 1.
buscarPersona([Dni|T]):- retract(persona(Dni,_,Edad,_,_)), Edad >= 65, buscarPersona(T).
buscarPersona([]).


buscarMedicamentos([Dni|T]):-persona(Dni,_,_,ObraSocial,Plan),buscar100(ObraSocial,Plan,Cant),
                             Cant >= 2, writeln(Dni),buscarMedicamentos(T).
buscarMedicamentos([_|T]):-buscarMedicamentos(T).
buscarMedicamentos([]).


buscar100(ObraSocial,Plan,Cant):-retract(obraSocial(ObraSocial,Plan,_,100)),
                                 buscar100(ObraSocial,Plan,Cant_ant), Cant is Cant_ant + 1.
buscar100(_,_,0).


%Opcion 2.
buscarPersona2([H|T]):-contarObra(H,Cant), Cant > 1, buscarPersona2(T).
buscarPersona2([]).


contarObra(H,Cant):-retract(persona(H,_,_,_,_)),
                    contarObra(H,Cant_ant),Cant is Cant_ant + 1.
contarObra(_,0).

imprimir([Dni|T]):-persona(Dni,Nombre,Edad,_,_),
                   write('Dni: '),write(Dni),write(' - '),
                   write('Nombre: '),write(Nombre),write(' - '),
                   write('Edad: '),writeln(Edad),
                   imprimir(T).
imprimir([]).
