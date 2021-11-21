/*
('Ciudad 1', 'Ciudad 2').
conecta_con('Ciudad 1', 'Ciudad 6').
conecta_con('Ciudad 6', 'Ciudad 7').
conecta_con('Ciudad 3', 'Ciudad 4').
conecta_con('Ciudad 3', 'Ciudad 5').
conecta_con('Ciudad 5', 'Ciudad 7').
conecta_con('Ciudad 5', 'Ciudad 4').

conecta_con('Ciudad 1', 'Ciudad 7').
conecta_con('Ciudad 3', 'Ciudad 7').

conexion('Ciudad 1', 'Ciudad 4').
*/

conecta_con('Ciudad 1', 'Ciudad 2').
conecta_con('Ciudad 1', 'Ciudad 6').
conecta_con('Ciudad 6', 'Ciudad 7').
conecta_con('Ciudad 3', 'Ciudad 4').
conecta_con('Ciudad 3', 'Ciudad 5').
conecta_con('Ciudad 5', 'Ciudad 7').
conecta_con('Ciudad 5', 'Ciudad 4').
conecta_con('Ciudad 7', 'Ciudad 6').
conecta_con('Ciudad 6', 'Ciudad 1').


% Ciudad A tiene como destino la Ciudad B
conexion(A,B) :- conecta_con(A,B), A\=B.
conexion(A,B) :- conecta_con(A,Ciudad), conexion(Ciudad,B).






/*
llega_a([ciudad1,ciudad2,ciudad6]).
llega_a([ciudad2]).
llega_a([ciudad3,ciudad4,ciudad5]).
llega_a([ciudad4]).
llega_a([ciudad5,ciudad4,ciudad7]).
llega_a([ciudad6,ciudad7]).
llega_a([ciudad7]).
llega_a([ciudad8]).
llega_a([ciudad9]).
*/

conecta_con('Ciudad 1', 'Ciudad 2').
conecta_con('Ciudad 1', 'Ciudad 6').
conecta_con('Ciudad 6', 'Ciudad 7').
conecta_con('Ciudad 3', 'Ciudad 4').
conecta_con('Ciudad 3', 'Ciudad 5').
conecta_con('Ciudad 5', 'Ciudad 7').
conecta_con('Ciudad 5', 'Ciudad 4').

% Ciudad A tiene como destino la Ciudad B
conexion(A,B) :- conecta_con(A,B), A\=B.
conexion(A,B) :- conecta_con(A,Ciudad), conexion(Ciudad,B).