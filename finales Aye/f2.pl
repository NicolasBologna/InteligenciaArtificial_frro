%usuario(id,nombre, estado, edad, ciudad, [ids usuarios amigos]).
%provincia(id, nombre, [ids ciudades]).
%pais(id, nombre, [ids provincias]).
%El estado de un usuario puede ser activo o inactivo.

:-dynamic(usuario/6).
:-dynamic(provincia/3).
:-dynamic(pais/3).

inicio:-abrirDb, writeln('Ingrese opcion'),
                 writeln('1. Cantidad de usuarios activos en países con más de 3 provincias'),
                 writeln('2. Ingresar nuevo usuario'),
                 writeln('3. Salir'),
                 read(Op),opcion(Op).

abrirDb:-retractall(usuario(_,_,_,_,_,_)),retractall(provincia(_,_,_)),retractall(pais(_,_,_)),
         consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f2.txt').

guardar:-tell('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f2.txt'),listing(usuario),listing(provincia),listing(pais), told.


opcion(1):-usuariosActivos(Tot),write('La cantidad de usuarios activos que viven en paises con mas de 3 prov es: '),write(Tot),nl, inicio.
opcion(2):-agregarUsuario.
opcion(3):-writeln('Bye bye').

%Opcion 1.
usuariosActivos(Tot):-retract(usuario(_,_,activo,_,Ciu,_)),
                      provincia(Id_prov,_,List_loc), pertenece(List_loc, Ciu),
                      pais(_,_,List_prov), contarProv(List_prov,Cant),Cant>3, pertenece(List_prov, Id_prov),
                      usuariosActivos(Tot_ant), Tot is Tot_ant + 1.
usuariosActivos(0).


contarProv([_|T],Cant):-contarProv(T,Cant_ant),Cant is Cant_ant + 1.
contarProv([],0).


%Opcion 2.
agregarUsuario:-writeln('Ingrese nombre: '),read(Nom),
                writeln('Ingrese edad: '), read(Edad), Edad >= 18,
                writeln('Ingrese estado: '),read(Estado),
                writeln('Ingrese ciudad: '),read(Ciu),
                provincia(Id_prov,_,List_loc), pertenece(List_loc, Ciu),
                pais(_,'Argentina',List_prov),pertenece(List_prov, Id_prov),
                writeln('Ingrese nombre amigo o [] para finalizar: '),leer(List), calcularId(Cant), Id is Cant + 1,
                abrirDb,assert(usuario(Id,Nom,Estado,Edad,Ciu,List)),guardar,
                writeln('El usuario fue dado de alta por ser argentino > 18'), nl,inicio.
agregarUsuario:-writeln('No lo vamos a guardar porque no es argentino > 18'), nl,inicio.


calcularId(Cant):-retract(usuario(_,_,_,_,_,_)), calcularId(Cant_ant), Cant is Cant_ant + 1.
calcularId(0).


leer([H|T]):-read(N),N\=[],usuario(H,N,_,_,_,_),leer(T).
leer([]).


pertenece([H|_],H).
pertenece([_|T],H):-pertenece(T,H).



