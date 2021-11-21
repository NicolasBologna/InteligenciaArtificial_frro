%horoscopo(Signo,DiaInicio,MesIni,DiaFin,MesFin). 

horoscopo(acuario,21,1,18,2).
horoscopo(piscis,19,2,20,3).
horoscopo(aries,21,3,20,4).
horoscopo(tauro,21,4,21,5).
horoscopo(geminis,22,5,21,6).
horoscopo(cancer,22,6,22,7).
horoscopo(leo,23,7,23,8).
horoscopo(virgo,24,8,23,9).
horoscopo(libra,24,9,23,10).
horoscopo(escorpio,24,10,22,11).
horoscopo(sagitario,23,11,21,12).
horoscopo(capricornio,22,12,20,1).

signo(Dia,Mes,Signo) :- horoscopo(Signo,DiaInicio,Mes,_,_), DiaInicio=<Dia.
signo(Dia,Mes,Signo) :- horoscopo(Signo,_,_,DiaFin,Mes), Dia=<DiaFin.

