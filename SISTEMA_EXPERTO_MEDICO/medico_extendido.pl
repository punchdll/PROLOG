enfermedad(gripe).
enfermedad(rubeola).
enfermedad(malaria).
enfermedad(hepatitis).
enfermedad(tuberculosis).
enfermedad(anemia).
enfermedad(polipos_intestinales).
enfermedad(chikungunya).
enfermedad(sifilis_congenita).

enfermode(manuel, gripe).
tienesintoma(alicia, cansancio).

sintomade(tos, gripe).
sintomade(cansancio, gripe). 
sintomade(fiebre, gripe).
sintomade(dolorcabeza, gripe). 
sintomade(nausea, hepatitis). 
sintomade(diarrea, hepatitis). 
sintomade(ictericia, hepatitis). 
sintomade(cansancio, anemia). 
sintomade(apatia, anemia).
sintomade(nausea, anemia).
sintomade(tos, tuberculosis).
sintomade(cansancio, tuberculosis). 
sintomade(fiebre, tuberculosis). 
sintomade(escalofrios, tuberculosis). 
sintomade(escalofrios, malaria). 
sintomade(fiebre, malaria). 
sintomade(diarrea, malaria). 
sintomade(ictericia, malaria). 
sintomade(fiebre, rubeola). 
sintomade(jaqueca, rubeola). 
sintomade(secrecion, rubeola).
sintomade(sangradorectal, polipos_intestinales).
sintomade(diarrea, polipos_intestinales).
sintomade(estrenimientoprolongado, polipos_intestinales).
sintomade(dolorabdominal, polipos_intestinales).
sintomade(fatiga, polipos_intestinales).
sintomade(anemia, polipos_intestinales).
sintomade(fiebrealta, chikungunya).
sintomade(dolorarticular, chikungunya).
sintomade(dolormuscular, chikungunya).
sintomade(dolorcabeza, chikungunya).
sintomade(erupciones, chikungunya).
sintomade(fatigaextrema, chikungunya).
sintomade(nausea, chikungunya).
sintomade(conjuntivitis, chikungunya).
sintomade(lesionescutaneas, sifilis_congenita).
sintomade(secrecionnasal, sifilis_congenita).
sintomade(fiebre, sifilis_congenita).
sintomade(anemia, sifilis_congenita).
sintomade(ictericia, sifilis_congenita).
sintomade(retrasodesarrollo, sifilis_congenita).
sintomade(malformacionesoseas, sifilis_congenita).


buscar([], _ , 0). 

buscar(X, E, 1):- atomic(X), sintomade(X, E).

buscar(X, E, 0):- atomic(X), \+ sintomade(X, E).

buscar([X | Xs], E, P):- enfermedad(E) , buscar(X, E, S1) , buscar(Xs, E,S2) , P is S1 + S2.

cantSint(E , C):- findall(X , sintomade(X, E) , L) , length(L , R), C is R.

# Para el exclusivo
diagnostico(ListaSintomas, Enfermedad, 100) :-
    member(Sintoma, ListaSintomas),
    es_sintoma_exclusivo(Sintoma, Enfermedad).

# Para el normal
diagnostico([X|Xs] , E , K):- buscar([X | Xs] , E , P) , cantSint(E, T) , K is P * 100 / T.

medicinade(contrex, gripe).
medicinade(jarabe, gripe).
medicinade(pastillas, tuberculosis). 
medicinade(vacuna, malaria). 
medicinade(vacuna, rubeola). 
medicinade(vitaminas, anemia). 
medicinade(pastillas, hepatitis).>
medicinade(polipectomia, polipos_intestinales).
medicinade(paracetamol, chikungunya).
medicinade(acetaminofen, chikungunya).
medicinade(penicilina, sifilis_congenita).
medicinade(penicilina, sifilis_congenita).

recetade(M, S):- sintomade(S, Z), medicinade(M, Z).

especialistade(otorrino, gripe).
especialistade(nutricionista, anemia).
especialistade(endocrinologia, hepatitis).
especialistade(medicinageneral, rubeola). 
especialistade(nutricionista, tuberculosis). 
especialistade(medicinageneral, malaria).
especialistade(gastroenterologo, polipos_intestinales).
especialistade(cirujanodigestivo, polipos_intestinales).
especialistade(medicinageneral, chikungunya).
especialistade(infectologo, chikungunya).
especialistade(neonatologo, sifilis_congenita).
especialistade(pediatrainfectologo, sifilis_congenita).

atiende_especialista(E, S):- sintomade(S, Z), especialistade(E, Z).

mereceta(Es, M, E) :- medicinade(M, E), especialistade(Es, E).

# Para sintoma exclusivo
es_sintoma_exclusivo(S, E) :-
    sintomade(S, E),
    findall(OtraEnfermedad, (sintomade(S, OtraEnfermedad), OtraEnfermedad \= E), ListaOtras),
    length(ListaOtras, 0).
