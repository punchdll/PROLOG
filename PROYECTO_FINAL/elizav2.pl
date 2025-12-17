:- dynamic sintoma_usuario/1.

eliza :-
    writeln('Hola, mi nombre es Eliza.
    Por favor, ingresa tu consulta usando solo minúsculas
    y sin punto al final:'),
    readln(Input),
    eliza(Input), !.

eliza(Input) :-
    Input == ['Adios'],
    writeln('Adiós. Espero haberte ayudado.'), !.

eliza(Input) :-
    Input == ['Adios', '.'],
    writeln('Adiós. Espero haberte ayudado.'), !.

eliza(Input) :-
    template(Stim, Resp, IndStim),
    match(Stim, Input),
    % si he llegado aquí es que he
    % hallado el template correcto:
    replace0(IndStim, Input, 0, Resp, R),
    writeln(R),
    readln(Input1),
    eliza(Input1), !.

template([hola, mi, nombre, es, s(_), '.'], ['Hola', 0, '¿', 'Cómo', estás, tú, '?'], [4]).
template([buendia, mi, nombre, es, s(_), '.'], ['Buen', 'día', 0, '¿', 'Cómo', estás, tú, '?'], [4]).
template([buenos, dias, mi, nombre, es, s(_), '.'], ['Buenos', 'días', 0, '¿', 'Cómo', estás, tú, '?'], [5]).

template([hola, ',', mi, nombre, es, s(_), '.'], ['Hola', 0, '¿', 'Cómo', estás, tú, '?'], [5]).
template([buendia, ',', mi, nombre, es, s(_), '.'], ['Buen', 'día', 0, '¿', 'Cómo', estás, tú, '?'], [5]).

template([hola, _], ['Hola', '¿', 'Cómo', estás, tú, '?'], []).
template([buendia, _], ['Buen', 'día', '¿', 'Cómo', estás, tú, '?'], []).
template([buenos, dias, _], ['Buenos', 'días', '¿', 'Cómo', estás, tú, '?'], []).
template([hi, _], ['Hola', '¿', 'Cómo', estás, tú, '?'], []).
template([hello, _], ['Hola', '¿', 'Cómo', estás, tú, '?'], []).

template([yo, creo, que, soy, s(_), '.'], ['¿', 'Por', 'qué', crees, que, eres, 0, '?'], [4]).
template([yo, s(_), a, ti, '.'], ['¿', 'Por', 'qué', me, 0, '?'], [1]).
template([yo, soy, s(_), '.'], ['¿', 'Por', 'qué', eres, 0, '?'], [2]).

% pregunta algo que le gusta a eliza
template([te, gustan, las, s(_), _], [flagLike], [3]).
template([te, gustan, los, s(_), _], [flagLike], [3]).

% pregunta algo que hace eliza
template([tu, eres, s(_), _], [flagDo], [2]).

% pregunta algo que es eliza
template([que, eres, tu, s(_)], [flagIs], [3]).
template([eres, s(_), '?'], [flagIs], [1]).

%===========================================================
% Templates para el Proyecto Final
%===========================================================
template([quien, es, s(_), '?'], [flagPersonaje], [2]).
template([conoces, a, s(_), '?'], [flagPersonaje], [2]).
template([hablame, de, s(_), '?'], [flagPersonaje], [2]).
template([sabes, quien, es, s(_), '?'], [flagPersonaje], [3]).

template([s(_), es, adulto, '?'], [flagAdulto], [0]).
template([es, s(_), un, adulto, '?'], [flagAdulto], [1]).

template([cuales, son, los, sintomas, de, s(_), '?'], [flagSintomas], [5]).
template([que, sintomas, tiene, s(_), '?'], [flagSintomas], [3]).
template([como, se, manifiesta, la, s(_), '?'], [flagSintomas], [4]).
template([que, se, siente, con, s(_), '?'], [flagSintomas], [4]).
template([como, saber, si, tengo, s(_), '?'], [flagSintomas], [4]).
template([signos, de, s(_), '?'], [flagSintomas], [2]).

% --- Templates Nuevas Actividades Medico Extendido ---
template([tengo, s(_)], [flagAddSintoma], [1]).
template([siento, s(_)], [flagAddSintoma], [1]).
template([padezco, s(_)], [flagAddSintoma], [1]).
template([presento, s(_)], [flagAddSintoma], [1]).

template([borrar, sintomas], [flagClearSintomas], []).
template([limpiar, sintomas], [flagClearSintomas], []).
template([reiniciar, paciente], [flagClearSintomas], []).
template([nuevo, paciente], [flagClearSintomas], []).

template([probabilidad, de, s(_), '?'], [flagCalcularProbabilidad], [2]).
template([que, probabilidad, tengo, de, s(_), '?'], [flagCalcularProbabilidad], [5]).
template([posibilidad, de, s(_), '?'], [flagCalcularProbabilidad], [2]).

template([diagnostico, preventivo], [flagDiagnosticoPreventivo], []).
template([alerta, preventiva], [flagDiagnosticoPreventivo], []).
template([que, podria, tener], [flagDiagnosticoPreventivo], []).

template([es, s(_), similar, a, s(_), '?'], [flagSimilares], [1, 4]).
template([se, parecen, la, s(_), y, la, s(_), '?'], [flagSimilares], [3, 6]).
template([relacion, entre, s(_), y, s(_), '?'], [flagSimilares], [2, 4]).

template([tengo, sintomas, contradictorios, '?'], [flagContradictorios], []).
template([hay, contradiccion], [flagContradictorios], []).
template([mis, sintomas, tienen, sentido, '?'], [flagContradictorios], []).

template([diagnostico, exacto], [flagArbol], []).
template([diagnostico, definitivo], [flagArbol], []).
template([que, tengo, exs síntomas al inicio para respetar los ingresados manualmenteactamente], [flagArbol], []).

template([diagnostico, exclusivo], [flagDiagnosticoExclusivo], []).
template([tengo, algun, sintoma, unico], [flagDiagnosticoExclusivo], []).

template([riesgo, de, s(_), '?'], [flagRiesgo], [2]).
template([es, peligrosa, la, s(_), '?'], [flagRiesgo], [3]).

template([tratamiento, combinado], [flagTratamientoCombinado], []).
template([todos, los, tratamientos], [flagTratamientoCombinado], []).

template([recomendacion, severidad, s(_), '?'], [flagRecomendacionSeveridad], [2]).
template([que, tan, grave, es, mi, s(_), '?'], [flagRecomendacionSeveridad], [5]).

template([diagnosticar, y, tratar], [flagDiagnosticarYTratar], []).
template([dame, el, remedio], [flagDiagnosticarYTratar], []).

template([reporte, completo], [flagReporte], []).
template([resumen], [flagReporte], []).
template([informe], [flagReporte], []).
% -----------------------------------------------------

template([diagnosticame, por, probabilidad], [flagDiagnosticoProbabilidad], []).
template([diagnosticame], [flagDiagnostico], []).

template([cual, es, el, tratamiento, de, s(_), '?'], [flagTratamiento], [5]).
template([como, se, cura, la, s(_), '?'], [flagTratamiento], [4]).
template([que, puedo, tomar, para, s(_), '?'], [flagTratamiento], [4]).
template([remedio, para, s(_), '?'], [flagTratamiento], [2]).
template([cura, para, s(_), '?'], [flagTratamiento], [2]).

template([es, grave, la, s(_), '?'], [flagGravedad], [3]).
template([que, gravedad, tiene, la, s(_), '?'], [flagGravedad], [4]).
template([que, gravedad, tiene, el, s(_), '?'], [flagGravedad], [4]).
template([es, grave, el, s(_), '?'], [flagGravedad], [3]).

template([que, me, recomiendas, para, s(_), '?'], [flagRecomendacion], [5]).
template([que, hago, si, tengo, s(_), '?'], [flagRecomendacion], [4]).
template([dame, una, recomendacion, para, s(_), '?'], [flagRecomendacion], [5]).

template([quien, es, el, padre, de, s(_), '?'], [flagPadre], [5]).
template([como, se, llama, el, papa, de, s(_), '?'], [flagPadre], [6]).
template([quien, es, papa, de, s(_), '?'], [flagPadre], [4]).

template([quien, es, la, madre, de, s(_), '?'], [flagMadre], [5]).
template([como, se, llama, la, mama, de, s(_), '?'], [flagMadre], [6]).
template([quien, es, mama, de, s(_), '?'], [flagMadre], [4]).

template([quienes, son, personajes, de, s(_), '?'], [flagPersonajeDe], [4]).

template([quien, es, hijo, de, s(_), '?'], [flagHijo], [4]).
template([cuales, son, los, hijos, de, s(_), '?'], [flagHijo], [5]).

template([quien, es, hermano, de, s(_), '?'], [flagHermano], [4]).
template([quien, es, la, hermana, de, s(_), '?'], [flagHermano], [5]).
template([quienes, son, los, hermanos, de, s(_), '?'], [flagHermano], [5]).

template([quien, es, abuelo, de, s(_), '?'], [flagAbuelo], [4]).
template([quien, es, el, abuelo, de, s(_), '?'], [flagAbuelo], [5]).

template([quien, es, tio, de, s(_), '?'], [flagTio], [4]).
template([quien, es, sobrino, de, s(_), '?'], [flagSobrino], [4]).
template([quien, es, primo, de, s(_), '?'], [flagPrimo], [4]).

template([cuantos, s(_), hay, en, la, familia, '?'], [flagContar], [1]).
template([cuantas, s(_), hay, en, la, familia, '?'], [flagContar], [1]).
template([cuantos, s(_), hay, en, los, simpson, '?'], [flagContarSimpson], [1]).
template([cuantas, s(_), hay, en, los, simpson, '?'], [flagContarSimpson], [1]).
%===========================================================

template([como, estas, tu, '?'], ['Yo', estoy, bien, ',', gracias, por, preguntar, '.'], []).

template([yo, pienso, que, _], [bueno, esa, es, tu, 'opinión'], []).
template([porque, _], [esa, no, es, una, buena, 'razón', '.'], []).
template([i, have, s(_), with, s(_), '.'], ['You', have, to, deal, with, your, 0, and, your, 1, in, a, mature, way, '.'], [2, 4]).
template([i, s(_), _], [i, can, recommend, you, a, book, about, that, issue], []).
template([please, s(_), _], ['No', i, can, not, help, ',', i, am, just, a, machine], []).
template([tell, me, a, s(_), _], ['No', i, can, not, ',', i, am, bad, at, that], []).

template(_, ['Please', explain, a, little, more, '.'], []).

% Lo que le gusta a eliza : flagLike
elizaLikes(X, R) :-
    likes(X),
    R = ['Sí', me, gusta, X].
elizaLikes(X, R) :-
    \+ likes(X),
    R = ['No', no, me, gusta, X].

likes(apples).
likes(ponies).
likes(zombies).
likes(manzanas).
likes(computadoras).
likes(carros).

% lo que hace eliza: flagDo
elizaDoes(X, R) :-
    does(X),
    R = ['Sí', yo, X, y, me, encanta].
elizaDoes(X, R) :-
    \+ does(X),
    R = ['No', yo, no, X, '.', es, muy, 'difícil', para, 'mí'].

does(study).
does(cook).
does(work).

% lo que es eliza: flagIs
elizaIs(X, R) :-
    is0(X),
    R = ['Sí', yo, soy, X].
elizaIs(X, R) :-
    \+ is0(X),
    R = ['No', yo, no, soy, X].

is0(dumb).
is0(weird).
is0(nice).
is0(fine).
is0(happy).
is0(redundant).

match([], []).
match([], _) :- true.

match([S|Stim], [I|Input]) :-
    atom(S), % si I es un s(X) devuelve falso
    S == I,
    match(Stim, Input), !.

match([S|Stim], [_|Input]) :-
    % I es un s(X), lo ignoro y continúo con el resto de la lista
    \+ atom(S),
    match(Stim, Input), !.

replace0([], _, _, [flagDiagnostico], R) :-
    elizaDiagnosticoInteractivo(R), !.

% Eliza likes:
replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagLike,
    elizaLikes(Atom, R).

% Eliza does:
replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagDo,
    elizaDoes(Atom, R).

% Eliza is:
replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagIs,
    elizaIs(Atom, R).

%==================================
%Replaces del proyecto
%==================================
replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagPersonaje,
    elizaPersonaje(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagAdulto,
    elizaAdulto(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagSintomas,
    elizaSintomas(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagTratamiento,
    elizaTratamiento(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagRecomendacion,
    elizaRecomendacion(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagGravedad,
    elizaGravedad(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagAddSintoma,
    elizaAddSintoma(Atom, R).

replace0([], _, _, [flagClearSintomas], R) :-
    retractall(sintoma_usuario(_)),
    R = ['Síntomas', borrados, correctamente, '.'], !.

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagCalcularProbabilidad,
    elizaCalcularProbabilidad(Atom, R).

replace0([], _, _, [flagDiagnosticoPreventivo], R) :-
    elizaDiagnosticoPreventivo(R), !.

replace0([], _, _, [flagDiagnosticoProbabilidad], R) :-
    elizaDiagnosticoProbabilidad(R), !.

replace0([I, J|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom1),
    nth0(J, Input, Atom2),
    nth0(0, Resp, X),
    X == flagSimilares,
    elizaSimilares(Atom1, Atom2, R).

replace0([], _, _, [flagContradictorios], R) :-
    elizaContradictorios(R), !.

replace0([], _, _, [flagArbol], R) :-
    elizaArbol(R), !.

replace0([], _, _, [flagDiagnosticoExclusivo], R) :-
    elizaDiagnosticoExclusivo(R), !.

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagRiesgo,
    elizaRiesgo(Atom, R).

replace0([], _, _, [flagTratamientoCombinado], R) :-
    elizaTratamientoCombinado(R), !.

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagRecomendacionSeveridad,
    elizaRecomendacionSeveridad(Atom, R).

replace0([], _, _, [flagDiagnosticarYTratar], R) :-
    elizaDiagnosticarYTratar(R), !.

replace0([], _, _, [flagReporte], R) :-
    elizaReporte(R), !.

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagPadre,
    elizaPadre(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagMadre,
    elizaMadre(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagHijo,
    elizaHijo(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagHermano,
    elizaHermano(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagAbuelo,
    elizaAbuelo(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagTio,
    elizaTio(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagSobrino,
    elizaSobrino(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagPrimo,
    elizaPrimo(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagPersonajeDe,
    elizaPersonajeDe(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagContar,
    elizaContar(Atom, R).

replace0([I|_], Input, _, Resp, R) :-
    nth0(I, Input, Atom),
    nth0(0, Resp, X),
    X == flagContarSimpson,
    elizaContarSimpson(Atom, R).

replace0([], _, _, Resp, R) :-
    append(Resp, [], R), !.

%==================================

replace0([I|Index], Input, N, Resp, R) :-
    length(Index, M),
    M =:= 0,
    nth0(I, Input, Atom),
    select(N, Resp, Atom, R1),
    append(R1, [], R), !.

replace0([I|Index], Input, N, Resp, R) :-
    nth0(I, Input, Atom),
    length(Index, M),
    M > 0,
    select(N, Resp, Atom, R1),
    N1 is N + 1,
    replace0(Index, Input, N1, R1, R), !.


% --- Modulo Medico Extendido (Integracion) ---

% Hechos copiados de medico_extendido.pl
tiene_sintoma(gripe, fiebre).
tiene_sintoma(gripe, dolor_cabeza).
tiene_sintoma(gripe, congestion).
tiene_sintoma(alergia, estornudos).
tiene_sintoma(alergia, picazon_ojos).
tiene_sintoma(alergia, congestion).
tiene_sintoma(migrana, dolor_cabeza_severo).
tiene_sintoma(migrana, sensibilidad_luz).
tiene_sintoma(migrana, nauseas).
tiene_sintoma(resfriado, estornudos).
tiene_sintoma(resfriado, congestion).
tiene_sintoma(resfriado, dolor_garganta).
tiene_sintoma(polipos_intestinales, sangrado_rectal).
tiene_sintoma(polipos_intestinales, diarrea).
tiene_sintoma(polipos_intestinales, estrenimiento_prolongado).
tiene_sintoma(polipos_intestinales, dolor_abdominal).
tiene_sintoma(polipos_intestinales, fatiga).
tiene_sintoma(polipos_intestinales, anemia).
tiene_sintoma(chikungunya, fiebre_alta).
tiene_sintoma(chikungunya, dolor_articular_intenso).
tiene_sintoma(chikungunya, dolor_muscular).
tiene_sintoma(chikungunya, dolor_cabeza).
tiene_sintoma(chikungunya, erupciones_piel).
tiene_sintoma(chikungunya, fatiga_extrema).
tiene_sintoma(chikungunya, nauseas).
tiene_sintoma(chikungunya, conjuntivitis).
tiene_sintoma(sifilis_congenita, lesiones_cutaneas).
tiene_sintoma(sifilis_congenita, secrecion_nasal).
tiene_sintoma(sifilis_congenita, fiebre).
tiene_sintoma(sifilis_congenita, anemia).
tiene_sintoma(sifilis_congenita, ictericia).
tiene_sintoma(sifilis_congenita, retraso_desarrollo).
tiene_sintoma(sifilis_congenita, malformaciones_oseas).

tratamiento(gripe, 'Reposo, hidratacion, paracetamol y aislamiento.').
tratamiento(alergia, 'Antihistaminicos y evitar el alergeno conocido.').
tratamiento(migrana, 'Medicacion especifica, ambiente oscuro y tranquilo.').
tratamiento(resfriado, 'Liquidos calientes, descongestionantes y vitamina C.').
tratamiento(polipos_intestinales, 'Polipectomia, dieta rica en fibra y evitar grasas.').
tratamiento(chikungunya, 'Paracetamol, hidratacion constante y reposo.').
tratamiento(sifilis_congenita, 'Penicilina G, control prenatal y seguimiento medico.').

recomendacion(gripe, 'Leve', 'Descanso y liquidos abundantes.').
recomendacion(gripe, 'Moderada', 'Reposo en cama y paracetamol.').
recomendacion(gripe, 'Severa', 'Acudir al medico por fiebre alta persistente.').
recomendacion(alergia, 'Leve', 'Evitar el alergeno y lavar zona afectada.').
recomendacion(alergia, 'Moderada', 'Uso de antihistaminicos de venta libre.').
recomendacion(alergia, 'Severa', 'Atencion medica urgente por dificultad respiratoria.').
recomendacion(migrana, 'Leve', 'Descanso en habitacion oscura y silenciosa.').
recomendacion(migrana, 'Moderada', 'Analgesicos y compresas frias.').
recomendacion(migrana, 'Severa', 'Consultar especialista para tratamiento profilactico.').
recomendacion(resfriado, 'Leve', 'Mantenerse hidratado y descansar.').
recomendacion(resfriado, 'Moderada', 'Vahos de eucalipto y descongestionantes.').
recomendacion(resfriado, 'Severa', 'Vigilar complicaciones respiratorias.').
recomendacion(polipos_intestinales, 'Leve', 'Aumentar ingesta de fibra y agua.').
recomendacion(polipos_intestinales, 'Moderada', 'Control medico periodico y dieta estricta.').
recomendacion(polipos_intestinales, 'Severa', 'Evaluacion quirurgica inmediata.').
recomendacion(chikungunya, 'Leve', 'Reposo y control de temperatura.').
recomendacion(chikungunya, 'Moderada', 'Analgesicos para dolor articular y reposo.').
recomendacion(chikungunya, 'Severa', 'Hospitalizacion si hay deshidratacion severa.').
recomendacion(sifilis_congenita, 'Leve', 'Seguimiento medico y antibioticos.').
recomendacion(sifilis_congenita, 'Moderada', 'Tratamiento con penicilina bajo supervision.').
recomendacion(sifilis_congenita, 'Severa', 'Manejo hospitalario de complicaciones.').

gravedad(gripe, alto).
gravedad(alergia, bajo).
gravedad(migrana, bajo).
gravedad(resfriado, bajo).
gravedad(chikungunya, medio).
gravedad(sifilis_congenita, medio).
gravedad(polipos_intestinales, alto).

% Hechos: Sintomas contradictorios
contradictorio(fiebre, picazon_ojos).
contradictorio(nauseas, estornudos).

% Lógica de interacción para Eliza
elizaSintomas(Enfermedad, R) :-
    findall(S, tiene_sintoma(Enfermedad, S), Sintomas),
    Sintomas \= [],
    atomic_list_concat(Sintomas, ', ', Texto),
    R = ['Los', 'síntomas', de, Enfermedad, son, ':', Texto].
elizaSintomas(Enfermedad, ['No', tengo, 'información', sobre, los, 'síntomas', de, Enfermedad]).

elizaTratamiento(Enfermedad, R) :-
    tratamiento(Enfermedad, T),
    R = ['El', tratamiento, para, Enfermedad, es, ':', T].
elizaTratamiento(Enfermedad, ['No', conozco, el, tratamiento, para, Enfermedad]).

elizaRecomendacion(Enfermedad, R) :-
    findall(Rec, recomendacion(Enfermedad, _, Rec), Lista),
    Lista \= [],
    atomic_list_concat(Lista, ' o ', Texto),
    R = ['Recomendaciones', para, Enfermedad, ':', Texto].
elizaRecomendacion(Enfermedad, ['No', tengo, recomendaciones, para, Enfermedad]).

elizaGravedad(Enfermedad, R) :-
    gravedad(Enfermedad, Nivel),
    R = ['La', gravedad, de, la, Enfermedad, es, ':', Nivel].
elizaGravedad(Enfermedad, ['No', tengo, informacion, sobre, la, gravedad, de, Enfermedad]).

elizaAddSintoma(Sintoma, R) :-
    assertz(sintoma_usuario(Sintoma)),
    R = ['Entendido', ',', he, registrado, que, tienes, Sintoma].


elizaDiagnosticoInteractivo(R) :-
    writeln('Para realizar el diagnóstico'),
    writeln('Responde con "si" o "no" a cada síntoma.'),
    % Ya no borramos síntomas al inicio para respetar los ingresados manualmente
    findall(S, tiene_sintoma(_, S), TodosSintomas),
    sort(TodosSintomas, SintomasUnicos),
    preguntar_sintomas(SintomasUnicos),
    calcular_diagnostico_extendido(R).

preguntar_sintomas([]).
preguntar_sintomas([S|Resto]) :-
    sintoma_usuario(S), !,
    preguntar_sintomas(Resto).
preguntar_sintomas([S|Resto]) :-
    format('¿Tienes ~w? ', [S]),
    readln(Resp),
    ( (member(si, Resp) ; member(s, Resp) ; member(yes, Resp)) ->
        assertz(sintoma_usuario(S))
    ;
        true
    ),
    preguntar_sintomas(Resto).

calcular_diagnostico_extendido(R) :-
    findall(Enf, tiene_sintoma(Enf, _), Enfs),
    sort(Enfs, EnfsUnicas),
    findall([Prob, E], (
        member(E, EnfsUnicas),
        probabilidad_enfermedad(E, Prob)
    ), Lista),
    sort(Lista, ListaOrdenada),
    reverse(ListaOrdenada, [[MejorProb, MejorEnf]|_]),
    (MejorProb > 0 ->
        format(atom(Porcentaje), '~2f', [MejorProb]),
        R = ['El', 'diagnóstico', más, probable, es, MejorEnf, con, un, Porcentaje, '%', de, probabilidad, '.']
    ;
        R = ['No', presento, suficientes, 'síntomas', para, un, 'diagnóstico', '.']
    ).

probabilidad_enfermedad(Enf, Prob) :-
    findall(S, tiene_sintoma(Enf, S), SintomasEnf),
    length(SintomasEnf, Total),
    findall(S, (member(S, SintomasEnf), sintoma_usuario(S)), SintomasPresentes),
    length(SintomasPresentes, Presentes),
    (Total > 0 -> Prob is (Presentes / Total) * 100 ; Prob is 0).

% --- Implementación de Actividades Solicitadas ---

% Diagnóstico directo por probabilidad (sin preguntas)
elizaDiagnosticoProbabilidad(R) :-
    calcular_diagnostico_extendido(R).

% Actividad 3: Diagnóstico por Probabilidad (Consulta específica)
elizaCalcularProbabilidad(Enfermedad, R) :-
    probabilidad_enfermedad(Enfermedad, Prob),
    format(atom(Porcentaje), '~2f', [Prob]),
    R = ['La', probabilidad, de, tener, Enfermedad, es, del, Porcentaje, '%'].

% Actividad 4: Diagnóstico Preventivo
elizaDiagnosticoPreventivo(R) :-
    setof(Enf, diagnostico_preventivo(Enf), Lista),
    atomic_list_concat(Lista, ', ', Texto),
    R = ['Atención', ':', 'podrías', estar, desarrollando, ':', Texto].
elizaDiagnosticoPreventivo(['No', hay, alertas, de, 'diagnóstico', preventivo, por, ahora]).

diagnostico_preventivo(Enfermedad) :-
    tiene_sintoma(Enfermedad, _),
    findall(S, tiene_sintoma(Enfermedad, S), SintomasEnf),
    length(SintomasEnf, Total),
    findall(S, (member(S, SintomasEnf), sintoma_usuario(S)), SintomasPresentes),
    length(SintomasPresentes, Presentes),
    Presentes > 0,
    Presentes < Total.

% Actividad 5: Enfermedades Similares
elizaSimilares(E1, E2, R) :-
    enfermedades_similares(E1, E2),
    R = ['Sí', E1, y, E2, son, enfermedades, similares, porque, comparten, 'síntomas'].
elizaSimilares(E1, E2, ['No', E1, y, E2, no, se, consideran, similares]).

enfermedades_similares(E1, E2) :-
    E1 \= E2,
    findall(S, (tiene_sintoma(E1, S), tiene_sintoma(E2, S)), Compartidos),
    length(Compartidos, N),
    N >= 2.

% Actividad 6: Detectar Síntomas Contradictorios
elizaContradictorios(R) :-
    sintomas_contradictorios,
    R = ['Advertencia', ':', 'Tienes', 'síntomas', contradictorios, verificados].
elizaContradictorios(['Tus', 'síntomas', parecen, consistentes]).

sintomas_contradictorios :-
    sintoma_usuario(S1),
    sintoma_usuario(S2),
    S1 \= S2,
    (contradictorio(S1, S2) ; contradictorio(S2, S1)).

% Actividad 7: Árbol de Decisión Médico (Diagnóstico Exacto)
elizaArbol(R) :-
    findall(E, arbol_diagnostico(E), Lista),
    Lista \= [],
    atomic_list_concat(Lista, ', ', Texto),
    R = ['Según', el, 'árbol', de, 'decisión', tienes, ':', Texto].
elizaArbol(['No', cumples, con, todos, los, 'síntomas', para, un, 'diagnóstico', exacto]).

arbol_diagnostico(Enfermedad) :-
    setof(E, S^tiene_sintoma(E, S), Enfs),
    member(Enfermedad, Enfs),
    forall(tiene_sintoma(Enfermedad, S), sintoma_usuario(S)).

% Actividad 2: Diagnóstico por Síntoma Exclusivo
elizaDiagnosticoExclusivo(R) :-
    sintoma_usuario(S),
    tiene_sintoma(E, S),
    \+ (tiene_sintoma(E2, S), E2 \= E),
    R = ['Diagnóstico', exclusivo, ':', E, debido, al, 'síntoma', único, S], !.
elizaDiagnosticoExclusivo(['No', se, ha, encontrado, un, 'diagnóstico', exclusivo, con, los, 'síntomas', proporcionados]).

% Actividad 8: Enfermedades Graves con Riesgo
elizaRiesgo(Enfermedad, R) :-
    riesgo(Enfermedad, Nivel),
    R = ['El', riesgo, de, la, Enfermedad, es, ':', Nivel].
elizaRiesgo(Enfermedad, ['No', se, detecta, riesgo, confirmado, para, Enfermedad]).

riesgo(Enfermedad, Nivel) :-
    arbol_diagnostico(Enfermedad),
    gravedad(Enfermedad, Nivel).

% Actividad 9: Tratamiento Combinado
elizaTratamientoCombinado(R) :-
    tratamiento_combinado(Lista),
    Lista \= [],
    atomic_list_concat(Lista, ' + ', Texto),
    R = ['Tratamientos', sugeridos, ':', Texto].
elizaTratamientoCombinado(['No', hay, tratamientos, combinados, aplicables]).

tratamiento_combinado(Lista) :-
    setof(Trat, Enf^(diagnostico_basico(Enf), tratamiento(Enf, Trat)), Lista).

diagnostico_basico(Enfermedad) :-
    tiene_sintoma(Enfermedad, S),
    sintoma_usuario(S).

% Actividad 10: Recomendaciones según Severidad
elizaRecomendacionSeveridad(Enfermedad, R) :-
    severidad(Enfermedad, Nivel),
    recomendacion(Enfermedad, Nivel, Rec),
    R = ['Debido', a, severidad, Nivel, ':', Rec].
elizaRecomendacionSeveridad(Enfermedad, ['No', puedo, determinar, la, severidad, para, darte, 'recomendación', de, Enfermedad]).

severidad(Enfermedad, 'Severa') :-
    findall(S, (tiene_sintoma(Enfermedad, S), sintoma_usuario(S)), L),
    length(L, C), C >= 3, !.
severidad(Enfermedad, 'Moderada') :-
    findall(S, (tiene_sintoma(Enfermedad, S), sintoma_usuario(S)), L),
    length(L, C), C =:= 2, !.
severidad(Enfermedad, 'Leve') :-
    findall(S, (tiene_sintoma(Enfermedad, S), sintoma_usuario(S)), L),
    length(L, C), C =:= 1, !.

% Actividad 11: Diagnosticar y Tratar en un Solo Paso
elizaDiagnosticarYTratar(R) :-
    arbol_diagnostico(D),
    tratamiento(D, T),
    R = ['Diagnóstico', ':', D, '.', 'Tratamiento', ':', T].
elizaDiagnosticarYTratar(['No', se, pudo, diagnosticar, y, tratar, nada, concretamente]).

% Actividad 12: Reporte Completo
elizaReporte(R) :-
    writeln('--- REPORTE MÉDICO ---'),
    findall(S, sintoma_usuario(S), Sintomas),
    format('Síntomas confirmados: ~w~n', [Sintomas]),
    writeln('Enfermedades posibles (Probabilidad):'),
    setof(E, S^tiene_sintoma(E, S), Enfs),
    forall(member(E, Enfs), (
        probabilidad_enfermedad(E, P),
        (P > 0 ->
            format('  - ~w: ~2f%~n', [E, P])
        ;
            true
        )
    )),
    writeln('Diagnóstico Final:'),
    findall(D, arbol_diagnostico(D), Diagnosticos),
    ( Diagnosticos \= [] ->
        forall(member(D, Diagnosticos), (
            format('  * Enfermedad: ~w~n', [D]),
            (severidad(D, Sev) -> format('    Severidad: ~w~n', [Sev]); true),
            (tratamiento(D, T) -> format('    Tratamiento: ~w~n', [T]); true),
            (severidad(D, Sev2), recomendacion(D, Sev2, Rec) -> format('    Recomendación: ~w~n', [Rec]); true)
        ))
    ;
        writeln('  No se cumplen condiciones para un diagnóstico definitivo.')
    ),
    writeln('----------------------'),
    R = ['Reporte', generado, en, consola, '.'].

% --- Modulo Genealogico (Copiado de elizav1.pl) ---
% (Se mantiene igual que en la versión 1)
elizaPadre(Hijo, R) :-
    padre(Padre, Hijo),
    R = ['El', padre, de, Hijo, es, Padre].
elizaPadre(Hijo, ['No', 'sé', 'quién', es, el, padre, de, Hijo]).

elizaMadre(Hijo, R) :-
    madre(Madre, Hijo),
    R = ['La', madre, de, Hijo, es, Madre].
elizaMadre(Hijo, ['No', 'sé', 'quién', es, la, madre, de, Hijo]).

elizaHijo(Padre, R) :-
    findall(H, (padre(Padre, H) ; madre(Padre, H)), Lista),
    Lista \= [],
    atomic_list_concat(Lista, ', ', Texto),
    R = ['Los', hijos, de, Padre, son, ':', Texto].
elizaHijo(Padre, ['No', 'encontré', hijos, de, Padre]).

elizaHermano(Persona, R) :-
    setof(H, hermano(H, Persona), Lista),
    atomic_list_concat(Lista, ', ', Texto),
    R = ['Los', hermanos, de, Persona, son, ':', Texto].
elizaHermano(Persona, ['No', 'encontré', hermanos, de, Persona]).

elizaAbuelo(Nieto, R) :-
    setof(A, abuelo(A, Nieto), Lista),
    atomic_list_concat(Lista, ', ', Texto),
    R = ['Los', abuelos, de, Nieto, son, ':', Texto].
elizaAbuelo(Nieto, ['No', 'encontré', abuelos, de, Nieto]).

elizaTio(Sobrino, R) :-
    setof(T, tio(T, Sobrino), Lista),
    atomic_list_concat(Lista, ', ', Texto),
    R = ['Los', tios, de, Sobrino, son, ':', Texto].
elizaTio(Sobrino, ['No', 'encontré', tios, de, Sobrino]).

elizaSobrino(Tio, R) :-
    setof(S, sobrino(S, Tio), Lista),
    atomic_list_concat(Lista, ', ', Texto),
    R = ['Los', sobrinos, de, Tio, son, ':', Texto].
elizaSobrino(Tio, ['No', 'encontré', sobrinos, de, Tio]).

elizaPrimo(Persona, R) :-
    setof(P, primo(P, Persona), Lista),
    atomic_list_concat(Lista, ', ', Texto),
    R = ['Los', primos, de, Persona, son, ':', Texto].
elizaPrimo(Persona, ['No', 'encontré', primos, de, Persona]).

elizaContar(mujeres, R) :-
    findall(X, (miembro_grupo(X, familia), mujer(X)), L),
    length(L, N),
    R = ['Hay', N, mujeres, en, la, familia].

elizaContar(hombres, R) :-
    findall(X, (miembro_grupo(X, familia), hombre(X)), L),
    length(L, N),
    R = ['Hay', N, hombres, en, la, familia].

elizaContar(padres, R) :-
    setof(P, H^(padre(P, H), miembro_grupo(P, familia)), L),
    length(L, N),
    R = ['Hay', N, padres, en, la, familia].

elizaContar(madres, R) :-
    setof(M, H^(madre(M, H), miembro_grupo(M, familia)), L),
    length(L, N),
    R = ['Hay', N, madres, en, la, familia].

elizaContar(hijos, R) :-
    setof(H, P^((padre(P, H); madre(P, H)), miembro_grupo(H, familia)), L),
    length(L, N),
    R = ['Hay', N, hijos, en, la, familia].

elizaContar(abuelos, R) :-
    setof(A, N^((abuelo(A, N); abuela(A, N)), miembro_grupo(A, familia)), L),
    length(L, N),
    R = ['Hay', N, abuelos, '(', abuelos, y, abuelas, ')', en, la, familia].

elizaContar(X, ['No', se, como, contar, X, en, la, familia]).

elizaContarSimpson(mujeres, R) :-
    findall(X, (miembro_grupo(X, simpson), mujer(X)), L),
    length(L, N),
    R = ['Hay', N, mujeres, en, los, simpson].

elizaContarSimpson(hombres, R) :-
    findall(X, (miembro_grupo(X, simpson), hombre(X)), L),
    length(L, N),
    R = ['Hay', N, hombres, en, los, simpson].

elizaContarSimpson(padres, R) :-
    setof(P, H^(padre(P, H), miembro_grupo(P, simpson)), L),
    length(L, N),
    R = ['Hay', N, padres, en, los, simpson].

elizaContarSimpson(madres, R) :-
    setof(M, H^(madre(M, H), miembro_grupo(M, simpson)), L),
    length(L, N),
    R = ['Hay', N, madres, en, los, simpson].

elizaContarSimpson(hijos, R) :-
    setof(H, P^((padre(P, H); madre(P, H)), miembro_grupo(H, simpson)), L),
    length(L, N),
    R = ['Hay', N, hijos, en, los, simpson].

elizaContarSimpson(X, ['No', se, como, contar, X, en, los, simpson]).

% Hechos Familiares de serie
padre(homero, bart).
padre(homero, lisa).
padre(homero, maggie).
padre(abraham, homero).
padre(abraham, herb).
padre(clancy, marge).
padre(clancy, patty).
padre(clancy, selma).

% Familia
padre(roberto, carlos).
padre(roberto, ana).
padre(roberto, luis).
padre(roberto, elena).
padre(carlos, diego).
padre(carlos, valentina).
padre(jorge, mateo).
padre(jorge, camila).
padre(jorge, lucas).
padre(luis, gabriel).
padre(luis, isabella).
padre(pedro, alejandro).
padre(pedro, lucia).
padre(pedro, daniel).

madre(marge, bart).
madre(marge, lisa).
madre(marge, maggie).
madre(mona, homero).
madre(jackie, marge).
madre(jackie, patty).
madre(jackie, selma).
% Familia
madre(carmen, carlos).
madre(carmen, ana).
madre(carmen, luis).
madre(carmen, elena).
madre(sofia, diego).
madre(sofia, valentina).
madre(ana, mateo).
madre(ana, camila).
madre(ana, lucas).
madre(marta, gabriel).
madre(marta, isabella).
madre(elena, alejandro).
madre(elena, lucia).
madre(elena, daniel).

% Reglas familiares
hermano(X, Y) :- padre(P, X), padre(P, Y), X \= Y.
hermano(X, Y) :- madre(M, X), madre(M, Y), X \= Y.
abuelo(X, Y) :- padre(X, P), padre(P, Y).
abuelo(X, Y) :- padre(X, M), madre(M, Y).
abuela(X, Y) :- madre(X, P), padre(P, Y).
abuela(X, Y) :- madre(X, M), madre(M, Y).
tio(T, S) :- padre(P, S), hermano(T, P).
tio(T, S) :- madre(M, S), hermano(T, M).
sobrino(S, T) :- tio(T, S).
primo(P, S) :- tio(T, S), (padre(T, P) ; madre(T, P)).

% Género para la familia Garcia (para conteos)
hombre(roberto).
hombre(carlos).
hombre(jorge).
hombre(luis).
hombre(pedro).
hombre(diego).
hombre(mateo).
hombre(lucas).
hombre(gabriel).
hombre(alejandro).
hombre(daniel).

% Género Simpsons
hombre(homero).
hombre(bart).
hombre(flanders).
hombre(burns).
hombre(milhouse).
hombre(krusty).
hombre(moe).
hombre(skinner).
hombre(apu).
hombre(barney).
hombre(nelson).
hombre(smithers).
hombre(ralph).
hombre(gorgory).
hombre(lenny).
hombre(carl).

mujer(carmen).
mujer(sofia).
mujer(ana).
mujer(marta).
mujer(elena).
mujer(valentina).
mujer(camila).
mujer(isabella).
mujer(lucia).
mujer(marge).
mujer(lisa).
mujer(maggie).
mujer(edna).

% --- Modulo Personajes (Simpson) ---
elizaPersonaje(X, R) :-
    personaje(X, Descripcion),
    append([X], Descripcion, R).
elizaPersonaje(X, R) :-
    \+ personaje(X, _),
    R = ['Lo', siento, no, conozco, a, X].

elizaPersonajeDe(familia, R) :-
    findall(M, miembro_grupo(M, familia), Lista),
    Lista \= [],
    atomic_list_concat(Lista, ', ', Texto),
    R = ['Los', miembros, de, la, familia, son, ':', Texto].
elizaPersonajeDe(Grupo, R) :-
    Grupo \== familia,
    findall(P, miembro_grupo(P, Grupo), Lista),
    Lista \= [],
    atomic_list_concat(Lista, ', ', Texto),
    R = ['Los', personajes, de, Grupo, son, ':', Texto].
elizaPersonajeDe(Grupo, ['No', tengo, 'información', sobre, el, grupo, Grupo]).

miembro_grupo(X, simpson) :- member(X, [homero, marge, bart, lisa, maggie, flanders, burns, milhouse, krusty, moe, skinner, apu, barney, nelson, smithers, ralph, gorgory, lenny, carl, edna]).
miembro_grupo(X, simpsons) :- miembro_grupo(X, simpson).
miembro_grupo(X, familia) :- member(X, [roberto, carmen, carlos, sofia, ana, jorge, luis, marta, elena, pedro, diego, valentina, mateo, camila, lucas, gabriel, isabella, alejandro, lucia, daniel]).

personaje(homero, ['es', 'el', 'padre', 'de', 'la', 'familia', 'y', 'ama', 'la', 'cerveza']).
personaje(marge, ['es', 'la', 'madre', 'de', 'cabello', 'azul', 'y', 'voz', 'ronca']).
personaje(bart, ['es', 'el', 'hijo', 'mayor', 'travieso', 'y', 'rebelde']).
personaje(lisa, ['es', 'la', 'hija', 'inteligente', 'y', 'toca', 'el', 'saxofón']).
personaje(maggie, ['es', 'la', 'bebé', 'que', 'nunca', 'habla']).
personaje(flanders, ['es', 'el', 'vecino', 'religioso', 'y', 'zurdo']).
personaje(burns, ['es', 'el', 'millonario', 'dueño', 'de', 'la', 'planta', 'nuclear']).
personaje(milhouse, ['es', 'el', 'mejor', 'amigo', 'de', 'bart', 'y', 'usa', 'lentes']).
personaje(krusty, ['es', 'el', 'payaso', 'famoso', 'de', 'la', 'televisión']).
personaje(moe, ['es', 'el', 'dueño', 'de', 'la', 'taberna', 'de', 'springfield']).
personaje(skinner, ['es', 'el', 'director', 'de', 'la', 'escuela', 'primaria']).
personaje(apu, ['es', 'el', 'dueño', 'del', 'minisúper', 'kwik-e-mart']).
personaje(barney, ['es', 'el', 'amigo', 'borracho', 'de', 'homero']).
personaje(nelson, ['es', 'el', 'bravucón', 'que', 'se', 'ríe', 'de', 'todos']).
personaje(smithers, ['es', 'el', 'asistente', 'leal', 'del', 'señor', 'burns']).
personaje(ralph, ['es', 'el', 'hijo', 'del', 'jefe', 'gorgory', 'y', 'dice', 'cosas', 'raras']).
personaje(gorgory, ['es', 'el', 'jefe', 'de', 'policía', 'inepto']).
personaje(lenny, ['es', 'amigo', 'de', 'homero', 'y', 'trabaja', 'en', 'la', 'planta']).
personaje(carl, ['es', 'el', 'mejor', 'amigo', 'de', 'lenny']).
personaje(edna, ['es', 'la', 'maestra', 'de', 'bart']).

% Base de conocimiento de adultos
elizaAdulto(X, R) :-
    adulto(X),
    R = ['Sí', X, es, un, adulto].
elizaAdulto(X, R) :-
    \+ adulto(X),
    personaje(X, _),
    R = ['No', X, no, es, un, adulto].
elizaAdulto(X, R) :-
    \+ personaje(X, _),
    R = ['No', 'sé', 'quién', es, X].

adulto(homero).
adulto(marge).
adulto(flanders).
adulto(burns).
adulto(krusty).
adulto(moe).
adulto(skinner).
adulto(apu).
adulto(barney).
adulto(smithers).
adulto(gorgory).
adulto(lenny).
adulto(carl).
adulto(edna).

% Familia
adulto(roberto).
adulto(carmen).
adulto(carlos).
adulto(sofia).
adulto(ana).
adulto(jorge).
adulto(luis).
adulto(marta).
adulto(elena).
adulto(pedro).