padre(ned, robb).
padre(ned, sansa).
padre(ned, arya).
padre(rickard, ned).
madre(catelyn, robb).
madre(catelyn, sansa).
hombre(ned).
hombre(robb).
mujer(sansa).
mujer(arya).


progenitor(Progenitor, Hijo)    :-  padre(Progenitor, Hijo).
progenitor(Progenitor, Hijo)    :-  madre(Progenitor, Hijo).


hermano(Hermano_A, Hermano_B)   :-  progenitor(Progenitor, Hermano_A), 
                                    progenitor(Progenitor, Hermano_B),
                                    Hermano_A \== Hermano_B.

tio(Tio, Sobrino)               :-  progenitor(Padre_de_sobrino, Sobrino),
                                    hermano(Padre_de_sobrino, Tio).

abuelo(Abuelo, Nieto)           :-  progenitor(Abuelo, Padre),
                                    progenitor(Padre, Nieto).

hermana(Hermana, Objetivo)      :-  hermano(Hermana, Objetivo),
                                    mujer(Hermana).