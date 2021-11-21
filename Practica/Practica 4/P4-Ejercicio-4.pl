/*4. Ampliar el ejercicio 1 a través del uso de functores. Por ejemplo:
gasto(maria, super(coto,500)).
gasto(omar, tel(fijo,telecom,150)).
gasto(maria,tel(movil,personal,100)).
a. Ingresar un gasto (por ej. super) e informar todas las personas que
tienen dicho gasto.
b. Informar las personas que tienen un consumo superior a los $150 en un
cierto gasto (dato de entrada).
c. Calcular gasto promedio para una determinada persona (dato de
entrada).

consultarPersonas(Gasto):- gastos(Nombre, FunctorCargado),  functor(FunctorCargado, Gasto,_), write(Nombre), write(' ') ,writeln(FunctorCargado), retract(gastos(Nombre,FunctorCargado)), consultarPersonas(Gasto).
consultarPersonas(_).
*/


:-dynamic(gastos/2).

inicio:- writeln("ingrese la opcion: 1-Ingresar un gasto (por ej. super) e informar todas las personas que tienen dicho gasto."),
         writeln("2- Informar las personas que tienen un consumo superior a los $150 en un cierto gasto"),
         writeln("3- Calcular gasto promedio para una determinada persona"),
         writeln("4- Agregar nuevo gasto"),
         writeln("Otro- Salir"),
 read(Opc), opcion(Opc).

opcion(1):- retractall(gastos),abrir_base, write('Ingrese gasto'), read(Gasto), consultarPersonas(Gasto), inicio.

opcion(2):- retractall(gastos),abrir_base, write('Ingrese gasto'), read(Gasto), consumoSuperior(Gasto), inicio.

opcion(3):- retractall(gastos),abrir_base, write('Ingrese persona'), read(Persona), calcularGastos(Persona, CantTotal), write('Total gastado: '), writeln(CantTotal), inicio.

opcion(4):- agregar, inicio.

opcion(_):- writeln("Gracias por usar el sistema."). 

consultarPersonas(Gasto):- gastos(Nombre, FunctorCargado),  functor(FunctorCargado, Gasto,_), writeln(Nombre), retractall(gastos(Nombre,_)), consultarPersonas(Gasto).
consultarPersonas(_).

consumoSuperior(luz):- gastos(Nombre, luz(X)), X > 150, writeln(Nombre), retractall(gastos(Nombre,_)), consumoSuperior(luz).
consumoSuperior(super):- gastos(Nombre, super(X)), X > 150, writeln(Nombre), retractall(gastos(Nombre,_)), consumoSuperior(super).
consumoSuperior(telefono):- gastos(Nombre, telefono(_,X)), X > 150, writeln(Nombre), retractall(gastos(Nombre,_)), consumoSuperior(telefono).
consumoSuperior(_).

calcularGastos(Nombre, CantTotal):- calcularGastosLuz(Nombre, 0,SubtotalLuz), calcularGastosSuper(Nombre, 0,SubtotalSuper), calcularGastosTelefono(Nombre, 0,SubtotalTelefono), CantTotal is SubtotalLuz+SubtotalSuper+SubtotalTelefono.

calcularGastosLuz(Nombre, SubtotalLuz, TotalLuz):- gastos(Nombre,luz(X)), retract(gastos(Nombre,luz(X))), CantNuevo is SubtotalLuz + X, calcularGastosLuz(Nombre, CantNuevo, TotalLuz).
calcularGastosLuz(_, TotalLuz, TotalLuz).

calcularGastosSuper(Nombre, Subtotal, Total):- gastos(Nombre,super(X)), retract(gastos(Nombre,super(X))), CantNuevo is Subtotal + X, calcularGastosSuper(Nombre, CantNuevo, Total).
calcularGastosSuper(_, Total, Total).

calcularGastosTelefono(Nombre, Subtotal, Total):- gastos(Nombre,telefono(_,X)), retract(gastos(Nombre,telefono(_,X))), CantNuevo is Subtotal + X, calcularGastosTelefono(Nombre, CantNuevo, Total).
calcularGastosTelefono(_, Total, Total).

agregar :- abrir_base, agregarNuevo, guardar.

agregarNuevo :- write('Ingrese persona: '), read(Persona),
                write('Ingrese gasto: '), read(Gasto),
                write('Ingrese dinero: '), read(Dinero),
                armarGasto(Persona,Gasto,Dinero).
        
armarGasto(Persona,luz,Dinero):- assert(gastos(Persona, luz(Dinero))).
armarGasto(Persona,super,Dinero):- assert(gastos(Persona, super(Dinero))).
armarGasto(Persona,telefono,Dinero):- write('Ingrese el tipo de telefono a agregar'), read(TipoTel), assert(gastos(Persona, telefono(TipoTel, Dinero))).

armarGasto(_,_,_):- write('No es posible agregar este gasto'), agregarNuevo.

guardar :- tell('C:/Users/Nico/Documents/Prolog/Practica 4/P4-Ejercicio-4.txt'), listing(gastos), told.
abrir_base:- consult('C:/Users/Nico/Documents/Prolog/Practica 4/P4-Ejercicio-4.txt').

consultar :- abrir_base, writeln('Ingrese la persona a consultar: '), read(Persona), write(Persona), writeln(': ').



/*listar_gastos(Persona) :- gastos(Persona, Gasto, Monto),  write(Gasto), write(': '), writeln(Monto), retract(gastos(Persona,Gasto,Monto)), listar_gastos(Persona).
listar_gastos(_). */