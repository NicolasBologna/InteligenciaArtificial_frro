:-dynamic(cerveza/2).
:-dynamic(atributos_si/1).
:-dynamic(atributos_no/1).
:-dynamic(atributo/3).
:-dynamic(categorias_ya_seleccionadas/1).

inicio:-abrir_base, writeln('Bienvenido al sistema que determinará tu cerveza ideal.'), 
		writeln('Que desea hacer: 1-Descubrir cerveza., 2-Salir.'),
		read(Op), opcion(Op).
opcion(1):- cerveza(Cerveza,Atributos),not(validaAtributosNo(Atributos)), validaCerveza(Cerveza,Atributos).
opcion(1):- writeln('No tenemos ninguna cerveza que coincida con tus gustos.'), inicio.
opcion(2):- writeln('Gracias por utilizar nuestro Sistema Experto.').
opcion(_):- writeln('Las opciones disponibles son 1-Descubrir cerveza., 2-Salir.'), 
	  read(Op), opcion(Op).

% Valida que los atributos no esten en la lista de no (que se haya ingresado un "no" para ese atributo)
validaAtributosNo([H|_]):- atributos_no(H).
validaAtributosNo([_|T]):- validaAtributosNo(T).

validaCerveza(X,[]):- write('La cerveza indicada es: '), write(X),nl, inicio.
% Busca los atributos restantes a validar y los hace pasar por la verificación.
validaCerveza(X,[H|T]):- validaProxAtributo(H), validaCerveza(X,T).

% Busca por cada uno de los atributos, si se respondio por si. 
% Si encuentra el atributo en la lista de SI, debe buscar
% el proximo atributo, Si no esta en la lista de SI, pregunta por atributo.
validaProxAtributo(Codigo):- atributos_si(Codigo).
validaProxAtributo(Codigo):- pregunta(Codigo).

% Esta regla trae un atributo, verifica que la categoría a la cual pertenece no haya sido ya seleccionada 
% y pregunta sobre el atributo, guardando la respuesta del usuario con guardaResp
pregunta(Codigo):-atributo(Categoria,Codigo,Atributo),not(categorias_ya_seleccionadas(Categoria)), write(Atributo),write('? s/n'), nl, read(Rta), guardaResp(Rta,Codigo, Categoria).

% Guarda las respuestas en memoria.
guardaResp('s',X,Categoria):- assert(atributos_si(X)), assert(categorias_ya_seleccionadas(Categoria)).
guardaResp('n',X,_):- assert(atributos_no(X)), fail.

abrir_base:- retractall(cerveza(_,_)), retractall(atributos_si(_)), retractall(atributos_no(_)), retractall(atributo(_,_)), retractall(categorias_ya_seleccionadas(_)),
	consult('BaseConocimiento2.TXT').