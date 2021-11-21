%vuelo(origen, destino, tiempo[min])
vuelo('Salta','Cordoba',80).
vuelo('Cordoba','Formosa',120).
vuelo('Cordoba','Rosario',55).
vuelo('Cordoba','Neuquen',100).
vuelo('Cordoba','Mendoza',65).
vuelo('Formosa','Corrientes',50).
vuelo('Corrientes','Posadas',70).
vuelo('Corrientes', 'Parana',57).
vuelo('Corrientes','Santa Fe',93).
vuelo('Posadas','Parana',85).
vuelo('Santa Fe','Rosario',30).
vuelo('Rosario','Parana',25).
vuelo('Rosario','Buenos Aires',55).
vuelo('Rosario','Mendoza',175).
vuelo('Mendoza','Buenos Aires',85).
vuelo('Mendoza','Neuquen',83).
vuelo('Neuquen', 'Buenos Aires',90).
vuelo('Buenos Aires','Calafate',115).
vuelo('Buenos Aires', 'Puerto Madryn',75).
vuelo('Neuquen','Calafate',65).

menu:-
    write('Oceanic Airlines'),nl,
    write('Ingrese ciudad de origen: '),
    read(Origen),nl,
    write('Ingrese ciudad de destino'),
    read(Destino),nl,
    write('Desea itinerario con menor cantidad de transbordos posibles? Ingrese S o N'),
    read(ItinerarioMinimo),
    tipoBusqueda(Origen,Destino,ItinerarioMinimo,Solucion),
    reverse(Solucion,SolucionFinal),
    write('Los vuelos que se deben adquirir son: '),write(SolucionFinal),
    calculoDuracion(SolucionFinal,Duracion),
    write('La duracion total del viaje es: '),write(Duracion).
tipoBusqueda(Origen,Destino,'N',Solucion):- calculaRutaProf(Origen,Destino,Solucion), writeln("Cálculo de primer camino encontrado").
tipoBusqueda(Origen,Destino,'S',Solucion):- calculaRutaAnchura(Origen,Destino,Solucion), writeln("Cálculo de ruta mas corta").

%primero en profundidad:
calculaRutaProf(Inicio, Meta,Sol) :- buscaRuta(Inicio,Meta,[Inicio],Sol).
% Si el estado actual es la meta, devolver la ruta recorrida como soluci�n
buscaRuta(Estado, Estado, Ruta, Ruta).
% Generar un sucesor del estado actual. Si no fue visitado agregarlo a la ruta
buscaRuta(Estado, Meta, Ruta, Sol) :-
		sucesor(Estado,NuevoEstado),
                not(pertenece(NuevoEstado, Ruta)),
                buscaRuta(NuevoEstado, Meta, [NuevoEstado|Ruta], Sol).
pertenece(X,[X|_]).
pertenece(X,[_|T]):-pertenece(X,T).
% Generar el pr�ximo estado
sucesor(Estado,NuevoEstado):- vuelo(Estado,NuevoEstado,_).
sucesor(Estado,NuevoEstado):- vuelo(NuevoEstado,Estado,_).

%primero en anchura:
calculaRutaAnchura(Inicio, Meta,Sol) :-  buscaRuta([[Inicio]], Meta, Sol).
% Si el estado actual es la meta, devuelvo toda la ruta hacia el mismo
buscaRuta([[Estado|Ruta]|_],Estado,[Estado|Ruta]).
% generar las rutas sucesoras y agregarlas a Lista-Nodos, descartando la primera
buscaRuta([PrimerRuta|OtrasRutas],Meta,Sol) :-
		expandir(PrimerRuta, NuevasRutas),
		concatenar(OtrasRutas, NuevasRutas, NuevaListaNodos),
		buscaRuta(NuevaListaNodos,Meta,Sol).
% generamos las rutas sucesoras
expandir([Estado|Ruta],NuevasRutas):-
		findall([NuevoEstado,Estado|Ruta],
		     (sucesor(Estado,NuevoEstado),
	             not(pertenece(NuevoEstado,[Estado|Ruta]))),
		     NuevasRutas).
expandir(_,[]). % si no hay rutas sucesoras

% Regla para Concatenar
concatenar([],[],[]).
concatenar([H1|T1],L2,[H1|T3]):-concatenar(T1,L2,T3).
concatenar([],[H2|T2],[H2|T3]):-concatenar([],T2,T3).


%Calculo de la duraci�n total del viaje:
sucesor_duracion(Origen,NuevoOrigen,Tiempo):-
    vuelo(Origen,NuevoOrigen,Tiempo).
sucesor_duracion(Origen,NuevoOrigen,Tiempo):-
    vuelo(NuevoOrigen,Origen,Tiempo).

calculoDuracion([_|[]],0).
calculoDuracion([A,B|C],Duracion):-
    calculoDuracion([B|C],DuracionBC),
    sucesor_duracion(A,B,DuracionAB),
    Duracion is DuracionBC+DuracionAB.

