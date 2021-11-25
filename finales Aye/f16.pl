%cliente(dni,nombre,obrasocial).
%practica(cod,medico,fecha,dnicliente,asistio).

:-dynamic(cliente/3).
:-dynamic(practica/5).

inicio:-abrirDb, writeln('Ingrese dni del cliente para predecir si vendra a la consulta o no'),
        read(Dni),practicasYasistencias(Dni,Tot,Asist),prediccion(Tot,Asist).

abrirDb:-consult('C:/Users/manuv/OneDrive/Documentos/Prolog/finales/dbs/f16.txt').


practicasYasistencias(Dni,Tot,Asist):-practica(Cod,_,_,Dni,si),retract(practica(Cod,_,_,Dni,si)),practicasYasistencias(Dni,Tot_ant,Asist_ant),
                                      Tot is Tot_ant + 1, Asist is Asist_ant + 1.
practicasYasistencias(Dni,Tot,Asist):-practica(Cod,_,_,Dni,_),retract(practica(Cod,_,_,Dni,_)), practicasYasistencias(Dni,Tot_ant,Asist),
                                      Tot is Tot_ant + 1 .
practicasYasistencias(_,0,0).


prediccion(0,_):-writeln('No hay regitros de este chabon').
prediccion(Tot,Asist):-Asist/Tot > 0.8, writeln('Cae de una').
prediccion(_,_):-writeln('No va a venir capo').
