# Anotaciones

## Sandbox para practicar

https://swish.swi-prolog.org/

## Data util

https://www.tutorialspoint.com/prolog/prolog_lists.htm

## listas

### para contar elementos en una lista
```prolog
/*Versión profe*/ contadorEnListas([],0).
/*Probe y me anda*/ contadorEnListas([_|[]], 1).
contadorEnListas([_|T], Contador):- mostrarUltimo(T,ContPar), Contador is ContPar + 1.
```

### sumatoria de elementos en una lista
```prolog
sumatoria([], 0).
sumatoria([H|T], Sumatoria):- sumatoria(T,SumPar), Sumatoria is SumPar + H.
```
### promedio de elementos en una lista
```prolog
promedio([], 0, 0).
promedio([H|T], Sumatoria, Contador):- promedio(T,SumPar, ContParc), Sumatoria is SumPar + H, Contador is ContParc + 1.
```

### Buscar un elemento en la lista / Pertenece
```prolog
buscar([H|_], H).
buscar([_|T], Elemento):- buscar(T,Elemento).
buscar(_,_):- write('no se encontro el elemento'). /*Sacar para hacer el PERTENECE*/
```

### Traer el máximo de una lista
> This operation is used to find the maximum element from a list. We will define a predicate, list_max_elem(List, Max), then this will find Max element from the list and return.

- If there is only one element, then it will be the max element.

- Divide the list as `[X,Y|Tail]`. Now recursively find max of `[Y|Tail]` and store it into MaxRest, and store maximum of X and MaxRest, then store it to Max.

```prolog
max_of_two(X,Y,X) :- X >= Y.
max_of_two(X,Y,Y) :- X < Y.
list_max_elem([X],X).
list_max_elem([X,Y|Rest],Max) :- list_max_elem([Y|Rest],MaxRest), max_of_two(X,MaxRest,Max).
```

### para hacer busqueda en listas
```prolog
/*cuando tienen que estar todos los elementos*/
contiene([],_).
contiene([H2|T2], L3):- caracteristica(Nro,H2),pertenece(Nro,L3), contiene(T2,L3).

/*cuando tieneque haber al menos uno*/
contiene([H2|T2], L3):- caracteristica(Nro,H2),pertenece(Nro,L3).
contiene([_|T2], L3):- contiene(T2,L3).
```
---

> El tema de armar una lista nueva hay q tomarlo como lo siguiente:

1. A partir de la regla de fin (por ej `leer([]).`) como q se inicializa la lista [].
2. Después va tomando los valores que tiene ese parámetro en cada iteración. Por ejemplo, leiste "a, b, c, d" recursivamente entonces va llamando a la pila y va viendo esto:
   1. `leer([H|T]).` acá H = d -> `leer([d|T]).`
   2. `leer([H|T]).` acá H = c -> `leer([c|[d]]).`
   3. `leer([H|T]).` acá H = b -> `leer([b|[c,d]]).`
   4. `leer([H|T]).` acá H = a -> `leer([a|[b,c,d]]).`

(PONELE).

Para el caso de: Informar cuántas veces está ese elemento en la lista.

```prolog
contarElemento([],_,0). /*Condición de fin*/
contarElemento([H|T], Elemento, Cantidad):- H = Elemento, contarElemento(T,Elemento,CantParcial),  Cantidad is CantParcial + 1. /*los contadores y acumuladores siempre al final, aca pongo el H = Elemento antes de la recursividad pq queremos que el falso nos de antes de que haga toda la vuelta para atras*/
contarElemento([_|T], Elemento, Cantidad):- contarElemento(T, Elemento, Cantidad). /*para q sepa q hacer cuando H = Elemento es false*/
```

#### Transformar una cadena en una lista de caracteres. 
##### Acá hay que hacer lo mismo q en el read, ponemos una lista donde vamos "cargando" el H y pasamos el T a la recursividad.
```prolog
inicio:-read(Cadena), longitud(Cadena, Lista), write(Lista). 

longitud(Cadena, [H|T]):- sub_atom(Cadena,_,1,0,UltimoElemento), write(UltimoElemento),
    H = UltimoElemento, sub_atom(Cadena,0,_,1,SubCadena),writeln(SubCadena),longitud(SubCadena, T).
longitud('', []).
```

---

## PROLOG
---

### Tipos de Datos
```prolog
?- var(X1). => Yes
?- var(_). => Yes
?- var(_X1). => Yes
?- X1=a, var(X1). => No
?- atom(atomo). => Yes
?- atom('atomo'). => Yes
?- atom([]). => Yes
?- atom(3). => No
?- atom(1+2). => No
?- number(123). => Yes
?- number(-25.14). => Yes
?- number(1+3). => No
?- X is 1+3, number(X). => X=4 Yes
?- compound(1+2). => Yes
?- compound(f(X, a)). => Yes
?- compound([1,2]). => Yes
?- compound([]). => No
?- atomic(atomo). => Yes
?- atomic(123). => Yes
?- atomic(X). => No
?- atomic(f(1,2)). => No
```

### Operadores relacionales(OJO CON ESTOS 2)
```prolog
=< Menor o igual que
>= Mayor o igual que
```

> El predicado is/2 funciona como sentencia de asignación, dando un valor a una variable, pero siempre y cuando la variable sea libre.
Una variable no instanciada puede usarse con sentencias de asignación. El valor de las constantes o de otras variables instanciadas se vinculará a la variable libre. Esto se llama haber compartido el valor. Sin embargo en una cláusula que no tenga una variable libre, el Prolog evaluará matemáticamente la expresión y luego comprobará si es verdadera o falsa.


| Description | Syntax |
| ----------- | ----------- |
| Resto de la división entera  | X is 7 mod 2. |
| División entera X | is 7 // 2. |
 

---

sub_atom(+Atom, ?Before, ?Length, ?After, ?SubAtom)

sub_atom(Cadena,0,_,1,SubCadena) trae la cadena sin el ultimo elemento.

&copy; Agustín Elias y Nicolás Bologna
