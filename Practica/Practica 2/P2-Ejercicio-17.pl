persona('juan', ['salta','cordoba','santa fe']).
persona('nicolas', ['purmamarca','rosario','venado tuerto']).

inicio:- write("Ingrese persona: "),read(Persona), write("Ingrese ciudad: "),read(Ciudad),persona(Persona, ListaCiudades), pertenece(Ciudad,ListaCiudades), write(Persona), write(" viajó a "), write(Ciudad).

pertenece(X,[X|_]).
pertenece(X,[_|T]):-pertenece(X,T).

