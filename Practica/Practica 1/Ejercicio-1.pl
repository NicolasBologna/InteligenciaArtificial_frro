hombre(abraham).
hombre(herbert).
hombre(homero).
hombre(bart).
hombre(clancy).
mujer(mona).
mujer(marge).
mujer(lisa).
mujer(maggie).
mujer(jacqueline).
mujer(patty).
mujer(selma).
mujer(ling).
padres(bart, marge, homero).
padres(lisa, marge, homero).
padres(maggie, marge, homero).
padres(homero, mona, abraham).
padres(marge, jacqueline, clancy).
padres(patty, jacqueline, clancy).
padres(selma, jacqueline, clancy).

hermana(PersonaA, PersonaB) :- mujer(PersonaA), padres(PersonaA,Y,X), padres(PersonaB,Y,X).

nieto(SupuestoNieto,SupuestoAbuelo) :- hombre(SupuestoNieto), padres(SupuestoNieto,_,X), padres(X,SupuestoAbuelo,_).
nieto(SupuestoNieto,SupuestoAbuelo) :- hombre(SupuestoNieto), padres(SupuestoNieto,_,X), padres(X,_,SupuestoAbuelo).
nieto(SupuestoNieto,SupuestoAbuelo) :- hombre(SupuestoNieto), padres(SupuestoNieto,Y,_), padres(Y,SupuestoAbuelo,_).
nieto(SupuestoNieto,SupuestoAbuelo) :- hombre(SupuestoNieto), padres(SupuestoNieto,Y,_), padres(Y,_,SupuestoAbuelo).

abuelo(SupuestoAbuelo,SupuestoNieto) :- hombre(SupuestoAbuelo), padres(X,_,SupuestoAbuelo), padres(SupuestoNieto,_,X).
abuelo(SupuestoAbuelo,SupuestoNieto) :- hombre(SupuestoAbuelo), padres(Y,_,SupuestoAbuelo), padres(SupuestoNieto,Y,_).

tia(SupuestaTia,SupuestoSobrino) :- mujer(SupuestaTia), padres(SupuestoSobrino,X,_), padres(X,Abuela,Abuelo),padres(SupuestaTia,Abuela,Abuelo).
tia(SupuestaTia,SupuestoSobrino) :- mujer(SupuestaTia), padres(SupuestoSobrino,_,Y), padres(Y,Abuela,Abuelo),padres(SupuestaTia,Abuela,Abuelo).

/*Con reglas anteriores*/

tia(SupuestaTia,SupuestoSobrino) :- padres(SupuestoSobrino,_,Y), hermana(SupuestaTia,Y).
tia(SupuestaTia,SupuestoSobrino) :- padres(SupuestoSobrino,X,_), hermana(SupuestaTia,X).

