conecta_con(ciudad1, ciudad2).
conecta_con(ciudad1, ciudad6).
conecta_con(ciudad6, ciudad7).
conecta_con(ciudad3, ciudad4).
conecta_con(ciudad3, ciudad5).
conecta_con(ciudad5, ciudad7).
conecta_con(ciudad5, ciudad4).

% Alternativa 1
% Ciudad A tiene como destino la Ciudad B
conexion(A,B) :- conecta_con(A,B), A\=B.
conexion(A,B) :- conecta_con(A,Ciudad), conexion(Ciudad,B).