:-dynamic(cerveza/2).
:-dynamic(atributos_si/1).
:-dynamic(atributos_no/1).
:-dynamic(atributo/3).
:-dynamic(categorias_ya_seleccionadas/1).


inicio:-abrir_base, writeln('Bienvenido al sistema que determinar tu cerveza ideal.'), 
		writeln('Que desea hacer: 1-Descubrir cerveza., 2-Salir.'),
		read(Op), opcion(Op).
opcion(1):- cerveza(Cerveza,Atributos),validaAtributosNo(Atributos), validaCerveza(Cerveza,Atributos).
opcion(1):- writeln('No tenemos ninguna cerveza que coincida con tus gustos.'), inicio.
opcion(2):- writeln('Gracias por utilizar nuestro Sistema Experto.').
opcion(_):- writeln('Las opciones disponibles son 1-Descubrir cerveza., 2-Salir.'), 
	  read(Op), opcion(Op).

% valida que los atributos no esten en la lista de no (que no se haya ingresado un "no" para ese atributo)
validaAtributosNo([]).
validaAtributosNo([H|_]):- atributos_no(H), !,fail.
validaAtributosNo([_|T]):- validaAtributosNo(T).

validaCerveza(X,[]):- write('La cerveza indicada es: '), write(X),nl, inicio.

validaCerveza(X,[H|T]):- validaProxAtributo(H),!, validaCerveza(X,T).

% Busca por cada uno de los atributos, si se respondio por si o
% por no. Si encuentra el atributo en la lista de SI, debe buscar
% el proximo atributo, Si no esta en la lista de SI, pregunta por atributo.
validaProxAtributo(Codigo):- atributos_si(Codigo).
validaProxAtributo(Codigo):- pregunta(Codigo).

% esta funcion hace la pregunta sobre un atributo de una cerveza y
% devuelve true si lo tiene y sino falla
pregunta(Codigo):-atributo(Categoria,Codigo,Atributo),not(categorias_ya_seleccionadas(Categoria)), write(Atributo),write('? s/n'), nl, read(Rta), validaResp(Rta,Codigo, Categoria).

% El problema con q pregunta de nuevo es que si pusimos q es rubia, no quiere decir q NO sea negra.<

validaResp('s',X,Categoria):- assert(atributos_si(X)), assert(categorias_ya_seleccionadas(Categoria)).
validaResp('n',X,_):- assert(atributos_no(X)), fail.

abrir_base:- retractall(cerveza(_,_)), retractall(atributos_si(_)), retractall(atributos_no(_)), retractall(atributo(_,_)), retractall(categorias_ya_seleccionadas(_)),
	consult('C:/Users/Nico/Documents/Prolog/TPs/DB/BaseConocimiento2.TXT').