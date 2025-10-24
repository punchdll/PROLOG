%declaraciones de enfermedades

enfermedad(gripe).
enfermedad(rubeola).
enfermedad(malaria).
enfermedad(hepatitis).
enfermedad(tuberculosis).
enfermedad(anemia).

%Hechos que no entiendo

enfermo_de(manuel,gripe).
tiene_sintoma(alicia,cansancio).

sintoma_de(tos, gripe).
sintoma_de(cansancio, gripe). 
sintoma_de(fiebre, gripe). 
sintoma_de(dolor_cabeza, gripe). 
sintoma_de(nauseas, hepatitis). 
sintoma_de(diarrea, hepatitis). 
sintoma_de(ictericia, hepatitis). 
sintoma_de(cansancio, anemia). 
sintoma_de(apatia, anemia). 
sintoma_de(nausea, anemia). 
sintoma_de(tos, tuberculosis). 
sintoma_de(cansancio, tuberculosis). 
sintoma_de(fiebre, tuberculosis). 
sintoma_de(escalofrios, tuberculosis). 
sintoma_de(escalofrios, malaria). 
sintoma_de(fiebre , malaria). 
sintoma_de(diarrea , malaria). 
sintoma_de(ictericia, malaria). 
sintoma_de(fiebre, rubeola). 
sintoma_de(jaqueca, rubeola). 
sintoma_de(secrecion, rubeola). 

%Reglas para determinar que probabilidad una persona puede 
%tener una enfermedad X dado n síntomas

% %La función buscar busca las enfermedades que contengan 
%como mínimo los síntomas suministrados

%Primer parámetro (lista de enfermedades)
%Segundo parámetro (Enfermedad) 
%Tercer parámetro cantidad de ocurrencias

%E es la enfermedad

buscar([], _ , 0).

buscar(X , E , 1) :- sintoma_de(X, E).

buscar([X|Xs] , E , P) :- enfermedad(E) , buscar(X , E , S1) , buscar(Xs , E ,S2) , P is S1 + S2.


%%función que devuelve la cantidad de síntomas totales de la enfermedad seleccionada

cantidad_sintomas(E , C) :- findall(X , sintoma_de(X, E) , L) , length(L , R), C is R.

%%Esta función es parecida a la de buscar con la excepción que en el ultimo argumento te entrega
%% el (porcentaje de probabilidad de la enfermedad)

diagnostico([X|Xs] , E , K) :- buscar([X|Xs] , E , P) , cantidad_sintomas(E , T) , K is P * 100 / T.

%---------------------------------------------------------------------------------------------------------------------
%hasta alli llegamos en el primer informe, pero ahora añadiremos mas capacidad a nuestro SE.
%---------------------------------------------------------------------------------------------------------------------

%declaraciones de los hechos para determinar medicina de una enfermedad
%que medicamento debo tomar dependiendo la enfermedad

medicina_de(contrex, gripe). 
medicina_de(jarabe, gripe). 
medicina_de(pastillas, tuberculosis). 
medicina_de(vacuna, malaria). 
medicina_de(vacuna, rubeola). 
medicina_de(vitaminas, anemia). 
medicina_de(pastillas, hepatitis). 

%declaración de reglas
%receta médica según síntoma

receta_de(M, S):-sintoma_de(S, Z),medicina_de(M, Z).

especialista_de(otorrino, gripe).
especialista_de(nutricionista, anemia).
especialista_de(endocrinologia, hepatitis).
especialista_de(medicinageneral, rubeola).
especialista_de(nutricionista, tubercolosis).
especialista_de(medicinageneral, malaria). 

atiende_especialista(E, S):- sintoma_de(S,Z),especialista_de(E, Z).

% esta regla es para hacer consultas ejemplo
% Si tengo enfermedad gripe por ejemplo que especialista y que medicina
% me receta 

me_receta(Es, M, E):-medicina_de(M, E),sintoma_de(S, E), atiende_especialista(Es,S). 