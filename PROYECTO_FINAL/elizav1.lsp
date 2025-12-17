;;;; eliza.lisp

(defun eliza--space-p (c)
"Devuelve T si c es un separador de espacio/linea/tab."
(or (char= c #\Space) (char= c #\Tab) (char= c #\Newline) (char= c #\Return)))

(defparameter *eliza-punct-chars* ".,;:()?!\"'")

(defun clean-and-tokenize (line)
"Convierte LINE a minúsculas, sustituye puntuación por espacios y la divide en tokens."
(when line
    (let* ((lower (string-downcase line))
        (clean-str
            (with-output-to-string (out)
            (loop for c across lower do
                (if (find c *eliza-punct-chars* :test #'char-equal)
                    (write-char #\Space out)
                    (write-char c out))))))
    (let ((tokens '())
            (cur ""))
        (loop for c across clean-str do
        (if (eliza--space-p c)
            (when (> (length cur) 0)
                (push cur tokens)
                (setf cur ""))
            (setf cur (concatenate 'string cur (string c)))))
        (when (> (length cur) 0) (push cur tokens))
        (nreverse tokens)))))

(defparameter *templates*
(list
;; Hola … soy …
(list (list 'hola (list 's) 'como 'estas 'soy (list 's))
        (list "hola" 1 "como estas tu yo soy" 0 "como esta tu ?")
        (list 1 5))

;; Hola … soy …
(list (list 'hola (list 's) 'soy (list 's))
        (list "hola" 1 "mi nombre es" 0 "en que te puedo ayudar")
        (list 1 3))

;; Saludos simples
(list (list 'hola (list 's))
        (list "Hola" "como" "estas" "tu" "?")
        nil)

(list (list 'buendia (list 's))
        (list "Buendia" "Como" "estas" "tu" "?")
        nil)

(list (list 'yo 'creo 'que 'soy (list 's)) (list "¿" "Por" "qué" "crees" "que" "eres" 0 "?") (list 4))
(list (list 'yo (list 's) 'a 'ti) (list "¿" "Por" "qué" "me" 0 "?") (list 1))
(list (list 'yo 'soy (list 's)) (list "¿" "Por" "qué" "eres" 0 "?") (list 2))

;; flags (simulan predicados Prolog like/does/is...)
(list (list 'te 'gustan 'las (list 's) (list 's))
        (list 'flagLike)
        (list 3))

(list (list 'tu 'eres (list 's) (list 's))
        (list 'flagDo)
        (list 2))

(list (list 'que 'eres 'tu (list 's))
        (list 'flagIs)
        (list 3))

(list (list 'quien 'es (list 's))
        (list 'flagPersonaje)
        (list 2))
(list (list 'conoces 'a (list 's)) (list 'flagPersonaje) (list 2))
(list (list 'hablame 'de (list 's)) (list 'flagPersonaje) (list 2))
(list (list 'sabes 'quien 'es (list 's)) (list 'flagPersonaje) (list 3))
(list (list 'dime 'quien 'es (list 's)) (list 'flagPersonaje) (list 3))

(list (list 'quien 'trata 'la (list 's)) (list 'flagEnfermedad) (list 3))
(list (list 'quien 'trata 'el (list 's)) (list 'flagEnfermedad) (list 3))
(list (list 'que 'especialista 've 'la (list 's)) (list 'flagEnfermedad) (list 4))
(list (list 'con 'quien 'voy 'si 'tengo (list 's)) (list 'flagEnfermedad) (list 5))
(list (list 'que 'medico 'atiende 'la (list 's)) (list 'flagEnfermedad) (list 4))
(list (list 'necesito 'un 'especialista 'para (list 's)) (list 'flagEnfermedad) (list 4))

(list (list 'cuales 'son 'los 'sintomas 'de 'la (list 's)) (list 'flagSintoma) (list 6))
(list (list 'cuales 'son 'los 'sintomas 'del (list 's)) (list 'flagSintoma) (list 5))
(list (list 'cuales 'son 'los 'sintomas 'de (list 's)) (list 'flagSintoma) (list 5))
(list (list 'que 'sintomas 'tiene 'la (list 's)) (list 'flagSintoma) (list 4))
(list (list 'que 'sintomas 'tiene (list 's)) (list 'flagSintoma) (list 3))
(list (list 'como 'se 'manifiesta 'la (list 's)) (list 'flagSintoma) (list 4))
(list (list 'que 'se 'siente 'con (list 's)) (list 'flagSintoma) (list 4))
(list (list 'sintomas 'de (list 's)) (list 'flagSintoma) (list 2))
(list (list 'como 'se 'si 'tengo (list 's)) (list 'flagSintoma) (list 4))

(list (list 'diagnosticame 'por 'probabilidad) (list 'flagDiagnostico) nil)
(list (list 'diagnosticame) (list 'flagDiagnostico) nil)

(list (list 'cual 'es 'el 'tratamiento 'de (list 's)) (list 'flagTratamiento) (list 5))
(list (list 'como 'se 'cura 'la (list 's)) (list 'flagTratamiento) (list 4))
(list (list 'que 'puedo 'tomar 'para (list 's)) (list 'flagTratamiento) (list 4))
(list (list 'como 'tratar 'la (list 's)) (list 'flagTratamiento) (list 3))
(list (list 'remedio 'para (list 's)) (list 'flagTratamiento) (list 2))

(list (list 'es 'grave 'la (list 's)) (list 'flagGravedad) (list 3))
(list (list 'que 'gravedad 'tiene 'la (list 's)) (list 'flagGravedad) (list 4))
(list (list 'que 'gravedad 'tiene 'el (list 's)) (list 'flagGravedad) (list 4))
(list (list 'es 'grave 'el (list 's)) (list 'flagGravedad) (list 3))
(list (list 'es 'peligrosa 'la (list 's)) (list 'flagGravedad) (list 3))
(list (list 'me 'debo 'preocupar 'por 'la (list 's)) (list 'flagGravedad) (list 5))

(list (list 'que 'me 'recomiendas 'para (list 's)) (list 'flagRecomendacion) (list 4))
(list (list 'que 'hago 'si 'tengo (list 's)) (list 'flagRecomendacion) (list 4))
(list (list 'dame 'una 'recomendacion 'para (list 's)) (list 'flagRecomendacion) (list 4))
(list (list 'consejo 'para (list 's)) (list 'flagRecomendacion) (list 2))
(list (list 'sugerencias 'para (list 's)) (list 'flagRecomendacion) (list 2))

(list (list 'quien 'es 'el 'padre 'de (list 's)) (list 'flagPadre) (list 5))
(list (list 'como 'se 'llama 'el 'papa 'de (list 's)) (list 'flagPadre) (list 6))
(list (list 'papa 'de (list 's)) (list 'flagPadre) (list 2))
(list (list 'quien 'es 'la 'madre 'de (list 's)) (list 'flagMadre) (list 5))
(list (list 'como 'se 'llama 'la 'mama 'de (list 's)) (list 'flagMadre) (list 6))
(list (list 'mama 'de (list 's)) (list 'flagMadre) (list 2))
(list (list 'quien 'es 'hijo 'de (list 's)) (list 'flagHijo) (list 4))
(list (list 'cuales 'son 'los 'hijos 'de (list 's)) (list 'flagHijo) (list 5))
(list (list 'hijos 'de (list 's)) (list 'flagHijo) (list 2))
(list (list 'quien 'es 'hermano 'de (list 's)) (list 'flagHermano) (list 4))
(list (list 'quien 'es 'la 'hermana 'de (list 's)) (list 'flagHermano) (list 5))
(list (list 'quienes 'son 'los 'hermanos 'de (list 's)) (list 'flagHermano) (list 5))
(list (list 'quien 'es 'abuelo 'de (list 's)) (list 'flagAbuelo) (list 4))
(list (list 'quien 'es 'el 'abuelo 'de (list 's)) (list 'flagAbuelo) (list 5))
(list (list 'quien 'es 'tio 'de (list 's)) (list 'flagTio) (list 4))
(list (list 'quien 'es 'sobrino 'de (list 's)) (list 'flagSobrino) (list 4))
(list (list 'quien 'es 'primo 'de (list 's)) (list 'flagPrimo) (list 4))
(list (list 'quienes 'son 'personajes 'de (list 's)) (list 'flagPersonajeDe) (list 4))
(list (list 'lista 'de 'personajes 'de (list 's)) (list 'flagPersonajeDe) (list 4))
(list (list 'quien 'sale 'en (list 's)) (list 'flagPersonajeDe) (list 3))
(list (list 'cuantos (list 's) 'hay 'en 'la 'familia) (list 'flagContar) (list 1))
(list (list 'cuantas (list 's) 'hay 'en 'la 'familia) (list 'flagContar) (list 1))

(list (list (list 's) 'es 'adulto) (list 'flagAdulto) (list 0))
(list (list 'es (list 's) 'un 'adulto) (list 'flagAdulto) (list 1))

;; fallback
(list nil (list "Please" "explain" "a" "little" "more" ".") nil)
))


(defun element-match-p (templ-el token)
"Coincidencia de un elemento con token."
(cond
    ((null templ-el) t)
    ((and (consp templ-el)
        (symbolp (first templ-el))
        (string-equal (symbol-name (first templ-el)) "s"))
    (not (null token)))   ;; wildcard s => un token
    ((symbolp templ-el)
    (and token (string-equal (symbol-name templ-el) token)))
    (t nil)))

(defun match-template (stim input)
"Devuelve T si stim coincide con input."
(labels ((rec (slist ilist)
            (cond
            ((null slist) t)
            ((null ilist) nil)
            (t
                (let ((se (first slist))
                    (it (first ilist)))
                (if (element-match-p se it)
                    (rec (rest slist) (rest ilist))
                    nil))))))
    (rec stim input)))


(defun get-token-at (input pos)
(if (and input (>= pos 0) (< pos (length input)))
    (nth pos input)
    ""))

(defun build-response-from-resp (resp indices input)
"Sustituye enteros por tokens según índices."
(mapcan
(lambda (e)
    (cond
    ((integerp e)
        (let ((idx (and indices (nth e indices))))
        (list (get-token-at input (or idx -1)))))
    ((symbolp e) (list (symbol-name e)))
    ((stringp e) (list e))
    (t (list (princ-to-string e)))))
resp))

(defparameter *simpsons-db*
'(("homero" "es" "el" "padre" "de" "la" "familia" "y" "ama" "la" "cerveza")
    ("marge" "es" "la" "madre" "de" "cabello" "azul" "y" "voz" "ronca")
    ("bart" "es" "el" "hijo" "mayor" "travieso" "y" "rebelde")
    ("lisa" "es" "la" "hija" "inteligente" "y" "toca" "el" "saxofon")
    ("maggie" "es" "la" "bebe" "que" "nunca" "habla")
    ("flanders" "es" "el" "vecino" "religioso" "y" "zurdo")
    ("burns" "es" "el" "millonario" "dueno" "de" "la" "planta" "nuclear")
    ("milhouse" "es" "el" "mejor" "amigo" "de" "bart" "y" "usa" "lentes")
    ("krusty" "es" "el" "payaso" "famoso" "de" "la" "television")
    ("moe" "es" "el" "dueno" "de" "la" "taberna" "de" "springfield")
    ("skinner" "es" "el" "director" "de" "la" "escuela" "primaria")
    ("apu" "es" "el" "dueno" "del" "minisuper" "kwik-e-mart")
    ("barney" "es" "el" "amigo" "borracho" "de" "homero")
    ("nelson" "es" "el" "bravucon" "que" "se" "rie" "de" "todos")
    ("smithers" "es" "el" "asistente" "leal" "del" "senor" "burns")
    ("ralph" "es" "el" "hijo" "del" "jefe" "gorgory" "y" "dice" "cosas" "raras")
    ("gorgory" "es" "el" "jefe" "de" "policia" "inepto")
    ("lenny" "es" "amigo" "de" "homero" "y" "trabaja" "en" "la" "planta")
    ("carl" "es" "el" "mejor" "amigo" "de" "lenny")
    ("edna" "es" "la" "maestra" "de" "bart")))

(defparameter *especialistas-db*
'(("sifilis_congenita" "neonatologo")
    ("gripe" "medico" "general")
    ("alergia" "alergologo")
    ("migrana" "neurologo")
    ("resfriado" "medico" "general")
    ("polipos_intestinales" "gastroenterologo")
    ("chikungunya" "infectologo")))

(defparameter *sintomas-db*
'(("gripe" "fiebre" "dolor_cabeza" "congestion")
    ("alergia" "estornudos" "picazon_ojos" "congestion")
    ("migrana" "dolor_cabeza_severo" "sensibilidad_luz" "nauseas")
    ("resfriado" "estornudos" "congestion" "dolor_garganta")
    ("polipos_intestinales" "sangrado_rectal" "diarrea" "estrenimiento_prolongado" "dolor_abdominal" "fatiga" "anemia")
    ("chikungunya" "fiebre_alta" "dolor_articular_intenso" "dolor_muscular" "dolor_cabeza" "erupciones_piel" "fatiga_extrema" "nauseas" "conjuntivitis")
    ("sifilis_congenita" "lesiones_cutaneas" "secrecion_nasal" "fiebre" "anemia" "ictericia" "retraso_desarrollo" "malformaciones_oseas")))

(defparameter *tratamientos-db*
'(("gripe" "Reposo, hidratacion y paracetamol")
("alergia" "Antihistaminicos y evitar alergenos")
("migrana" "Ambiente oscuro y analgesicos")
("resfriado" "Liquidos calientes y vitamina C")
("polipos_intestinales" "Polipectomia y dieta rica en fibra")
("chikungunya" "Paracetamol e hidratacion")
("sifilis_congenita" "Penicilina G y control medico")))

(defparameter *recomendaciones-db*
'(("gripe" "Descanso y liquidos abundantes" "Reposo en cama y paracetamol")
("alergia" "Evitar el alergeno y lavar zona afectada")
("migrana" "Descanso en habitacion oscura y silenciosa")
("resfriado" "Mantenerse hidratado y descansar")
("polipos_intestinales" "Aumentar ingesta de fibra y agua")
("chikungunya" "Reposo y control de temperatura")
("sifilis_congenita" "Seguimiento medico y antibioticos")))

(defparameter *gravedad-db*
'(("gripe" "alto")
("alergia" "bajo")
("migrana" "bajo")
("resfriado" "bajo")
("chikungunya" "medio")
("sifilis_congenita" "medio")
("polipos_intestinales" "alto")))

(defparameter *adultos-db*
'("homero" "marge" "flanders" "burns" "krusty" "moe" "skinner" "apu" "barney" "smithers" "gorgory" "lenny" "carl" "edna"
"roberto" "carmen" "carlos" "sofia" "ana" "jorge" "luis" "marta" "elena" "pedro"))

(defparameter *grupo-simpson*
'("homero" "marge" "bart" "lisa" "maggie" "flanders" "burns" "milhouse" "krusty" "moe" "skinner" "apu" "barney" "nelson" "smithers" "ralph" "gorgory" "lenny" "carl" "edna"))

(defparameter *grupo-familia*
'("roberto" "carmen" "carlos" "sofia" "ana" "jorge" "luis" "marta" "elena" "pedro" "diego" "valentina" "mateo" "camila" "lucas" "gabriel" "isabella" "alejandro" "lucia" "daniel"))

(defparameter *hombres-db*
'("roberto" "carlos" "jorge" "luis" "pedro" "diego" "mateo" "lucas" "gabriel" "alejandro" "daniel"))

(defparameter *mujeres-db*
'("carmen" "sofia" "ana" "marta" "elena" "valentina" "camila" "isabella" "lucia"))

(defparameter *likes-db*
'("apples" "ponies" "zombies" "manzanas" "computadoras" "carros"))

(defparameter *does-db*
'("study" "cook" "work"))

(defparameter *is-db*
'("dumb" "weird" "nice" "fine" "happy" "redundant"))

;; Genealogia: (Padre Hijo)
(defparameter *padre-db*
'(("homero" "bart") ("homero" "lisa") ("homero" "maggie")
("abraham" "homero") ("abraham" "herb")
("clancy" "marge") ("clancy" "patty") ("clancy" "selma")
("roberto" "carlos") ("roberto" "ana") ("roberto" "luis") ("roberto" "elena")
("carlos" "diego") ("carlos" "valentina")
("jorge" "mateo") ("jorge" "camila") ("jorge" "lucas")
("luis" "gabriel") ("luis" "isabella")
("pedro" "alejandro") ("pedro" "lucia") ("pedro" "daniel")))

(defparameter *madre-db*
'(("marge" "bart") ("marge" "lisa") ("marge" "maggie")
("mona" "homero")
("jackie" "marge") ("jackie" "patty") ("jackie" "selma")
("carmen" "carlos") ("carmen" "ana") ("carmen" "luis") ("carmen" "elena")
("sofia" "diego") ("sofia" "valentina")
("ana" "mateo") ("ana" "camila") ("ana" "lucas")
("marta" "gabriel") ("marta" "isabella")
("elena" "alejandro") ("elena" "lucia") ("elena" "daniel")))

;; Funciones auxiliares de genealogia
(defun get-parents (child)
(let ((parents '()))
    (dolist (pair *padre-db*)
    (if (string-equal (second pair) child) (push (first pair) parents)))
    (dolist (pair *madre-db*)
    (if (string-equal (second pair) child) (push (first pair) parents)))
    parents))

(defun get-children (parent)
(let ((children '()))
    (dolist (pair *padre-db*)
    (if (string-equal (first pair) parent) (push (second pair) children)))
    (dolist (pair *madre-db*)
    (if (string-equal (first pair) parent) (push (second pair) children)))
    children))

(defun get-siblings (person)
(let ((parents (get-parents person))
        (siblings '()))
    (dolist (p parents)
    (dolist (c (get-children p))
        (unless (string-equal c person)
        (pushnew c siblings :test #'string-equal))))
    siblings))

(defun get-grandparents (person)
(let ((parents (get-parents person))
        (grandparents '()))
    (dolist (p parents)
    (dolist (gp (get-parents p))
        (pushnew gp grandparents :test #'string-equal)))
    grandparents))

(defun get-uncles (person)
(let ((parents (get-parents person))
        (uncles '()))
    (dolist (p parents)
    (dolist (u (get-siblings p))
        (pushnew u uncles :test #'string-equal)))
    uncles))

(defun get-nephews (person)
(let ((siblings (get-siblings person))
        (nephews '()))
    (dolist (s siblings)
    (dolist (n (get-children s))
        (pushnew n nephews :test #'string-equal)))
    nephews))

(defun get-cousins (person)
(let ((uncles (get-uncles person))
        (cousins '()))
    (dolist (u uncles)
    (dolist (c (get-children u))
        (pushnew c cousins :test #'string-equal)))
    cousins))

;; Diagnostico Interactivo
(defun run-diagnosis-interactive ()
(format t "Para realizar el diagnostico, respondere con preguntas de si o no.~%")
(format t "Responde con 'si' o 'no' a cada sintoma.~%")
(let ((sintomas-usuario '())
        (all-sintomas '()))
    ;; Recolectar todos los sintomas unicos
    (dolist (entry *sintomas-db*)
    (dolist (s (cdr entry))
        (pushnew s all-sintomas :test #'string-equal)))
    (setf all-sintomas (sort all-sintomas #'string<))
    
    ;; Preguntar
    (dolist (s all-sintomas)
    (format t "¿Tienes ~a? " s)
    (finish-output)
    (let ((resp (read-line)))
        (when (or (string-equal resp "si") (string-equal resp "s") (string-equal resp "yes"))
        (push s sintomas-usuario))))
    
    ;; Calcular
    (let ((best-enf nil) (best-prob 0))
    (dolist (entry *sintomas-db*)
        (let* ((enf (car entry))
            (sints (cdr entry))
            (total (length sints))
            (match (count-if (lambda (s) (find s sintomas-usuario :test #'string-equal)) sints)))
        (let ((prob (if (> total 0) (* (/ match total) 100.0) 0)))
            (when (> prob best-prob)
            (setf best-prob prob)
            (setf best-enf enf)))))
    
    (if (and best-enf (> best-prob 0))
        (list "El" "diagnostico" "mas" "probable" "es" best-enf "con" "un" (format nil "~,2f%" best-prob) "de" "probabilidad.")
        (list "No" "presento" "suficientes" "sintomas" "para" "un" "diagnostico.")))))

(defun handle-flag (flag indices input)
(let ((arg-token (and indices (> (length indices) 0)
                        (get-token-at input (first indices)))))
    (case flag
    (flagLike (if (find arg-token *likes-db* :test #'string-equal)
                    (list "Sí" "me" "gusta" arg-token)
                    (list "No" "no" "me" "gusta" arg-token)))
    (flagDo   (if (find arg-token *does-db* :test #'string-equal)
                    (list "Sí" "yo" arg-token "y" "me" "encanta")
                    (list "No" "yo" "no" arg-token "." "es" "muy" "difícil" "para" "mí")))
    (flagIs   (if (find arg-token *is-db* :test #'string-equal)
                    (list "Sí" "yo" "soy" arg-token)
                    (list "No" "yo" "no" "soy" arg-token)))
    (flagPersonaje (let ((entry (assoc arg-token *simpsons-db* :test #'string-equal)))
                    (if entry
                        (append (list arg-token) (cdr entry))
                        (list "Lo" "siento" "no" "conozco" "a" arg-token))))
    (flagEnfermedad (let ((entry (assoc arg-token *especialistas-db* :test #'string-equal)))
                        (if entry
                            (append (list "La" arg-token "la" "atiende") (cdr entry))
                            (list "No" "se" "quien" "trata" arg-token))))
    (flagSintoma (let ((entry (assoc arg-token *sintomas-db* :test #'string-equal)))
                    (if entry
                        (append (list "Los" "sintomas" "de" arg-token "son") (cdr entry))
                        (list "No" "conozco" "los" "sintomas" "de" arg-token))))
    (flagTratamiento (let ((entry (assoc arg-token *tratamientos-db* :test #'string-equal)))
                    (if entry
                        (append (list "El" "tratamiento" "para" arg-token "es") (cdr entry))
                        (list "No" "conozco" "el" "tratamiento" "para" arg-token))))
    (flagRecomendacion (let ((entry (assoc arg-token *recomendaciones-db* :test #'string-equal)))
                    (if entry
                        (append (list "Recomendaciones" "para" arg-token ":") (cdr entry))
                        (list "No" "tengo" "recomendaciones" "para" arg-token))))
    (flagGravedad (let ((entry (assoc arg-token *gravedad-db* :test #'string-equal)))
                    (if entry
                        (append (list "La" "gravedad" "de" arg-token "es") (cdr entry))
                        (list "No" "tengo" "informacion" "sobre" "la" "gravedad" "de" arg-token))))
    (flagAdulto (if (find arg-token *adultos-db* :test #'string-equal)
                    (list "Si" arg-token "es" "un" "adulto")
                    (list "No" arg-token "no" "es" "un" "adulto")))
    (flagPadre (let ((parents (get-parents arg-token)))
                (if parents
                    (append (list "Los" "padres" "de" arg-token "son") parents)
                    (list "No" "se" "quien" "es" "el" "padre" "de" arg-token))))
    (flagMadre (let ((parents (get-parents arg-token))) ;; Simplificado, busca en ambos
                (if parents
                    (append (list "La" "madre" "de" arg-token "es") (intersection parents (mapcar #'car *madre-db*) :test #'string-equal))
                    (list "No" "se" "quien" "es" "la" "madre" "de" arg-token))))
    (flagHijo (let ((children (get-children arg-token)))
                (if children
                    (append (list "Los" "hijos" "de" arg-token "son") children)
                    (list "No" "encontre" "hijos" "de" arg-token))))
    (flagHermano (let ((siblings (get-siblings arg-token)))
                (if siblings
                    (append (list "Los" "hermanos" "de" arg-token "son") siblings)
                    (list "No" "encontre" "hermanos" "de" arg-token))))
    (flagAbuelo (let ((gps (get-grandparents arg-token)))
                (if gps
                    (append (list "Los" "abuelos" "de" arg-token "son") gps)
                    (list "No" "encontre" "abuelos" "de" arg-token))))
    (flagTio (let ((uncles (get-uncles arg-token)))
            (if uncles
                (append (list "Los" "tios" "de" arg-token "son") uncles)
                (list "No" "encontre" "tios" "de" arg-token))))
    (flagSobrino (let ((neps (get-nephews arg-token)))
                (if neps
                    (append (list "Los" "sobrinos" "de" arg-token "son") neps)
                    (list "No" "encontre" "sobrinos" "de" arg-token))))
    (flagPrimo (let ((cousins (get-cousins arg-token)))
                (if cousins
                    (append (list "Los" "primos" "de" arg-token "son") cousins)
                    (list "No" "encontre" "primos" "de" arg-token))))
    (flagPersonajeDe (cond
                    ((string-equal arg-token "familia")
                        (append (list "Los" "miembros" "de" "la" "familia" "son" ":") *grupo-familia*))
                    ((or (string-equal arg-token "simpson") (string-equal arg-token "simpsons"))
                        (append (list "Los" "personajes" "de" arg-token "son" ":") *grupo-simpson*))
                    (t (list "No" "tengo" "informacion" "sobre" "el" "grupo" arg-token))))
    (flagContar (cond
                ((string-equal arg-token "mujeres")
                (let ((count (count-if (lambda (x) (find x *mujeres-db* :test #'string-equal)) *grupo-familia*)))
                    (list "Hay" (princ-to-string count) "mujeres" "en" "la" "familia")))
                ((string-equal arg-token "hombres")
                (let ((count (count-if (lambda (x) (find x *hombres-db* :test #'string-equal)) *grupo-familia*)))
                    (list "Hay" (princ-to-string count) "hombres" "en" "la" "familia")))
                ((string-equal arg-token "padres")
                (let ((padres (remove-duplicates (mapcar #'first *padre-db*) :test #'string-equal)))
                    (let ((count (count-if (lambda (p) (find p *grupo-familia* :test #'string-equal)) padres)))
                    (list "Hay" (princ-to-string count) "padres" "en" "la" "familia"))))
                ((string-equal arg-token "madres")
                (let ((madres (remove-duplicates (mapcar #'first *madre-db*) :test #'string-equal)))
                    (let ((count (count-if (lambda (m) (find m *grupo-familia* :test #'string-equal)) madres)))
                    (list "Hay" (princ-to-string count) "madres" "en" "la" "familia"))))
                ((string-equal arg-token "hijos")
                (let ((hijos '()))
                    (dolist (pair *padre-db*) (push (second pair) hijos))
                    (dolist (pair *madre-db*) (push (second pair) hijos))
                    (setf hijos (remove-duplicates hijos :test #'string-equal))
                    (let ((count (count-if (lambda (h) (find h *grupo-familia* :test #'string-equal)) hijos)))
                    (list "Hay" (princ-to-string count) "hijos" "en" "la" "familia"))))
                ((string-equal arg-token "abuelos")
                (let ((abuelos (remove-duplicates (mapcan (lambda (p) (get-grandparents p)) *grupo-familia*) :test #'string-equal)))
                    (let ((count (count-if (lambda (gp) (find gp *grupo-familia* :test #'string-equal)) abuelos)))
                    (list "Hay" (princ-to-string count) "abuelos" "(" "abuelos" "y" "abuelas" ")" "en" "la" "familia"))))
                (t (list "No" "se" "como" "contar" arg-token "en" "la" "familia"))))
    (flagDiagnostico (run-diagnosis-interactive))
    (t (list "Please" "explain" "a" "little" "more" ".")))))


(defun find-matching-template (input)
(find-if (lambda (tpl)
            (let ((stim (first tpl)))
            (match-template stim input)))
        *templates*))


(defun respond-to (input)
(let ((tpl (find-matching-template input)))
    (when tpl
    (let* ((resp (second tpl))
            (indices (third tpl)))
        (if (and (consp resp) (symbolp (first resp))
                (find (first resp) '(flagPersonaje flagLike flagDo flagIs flagEnfermedad flagSintoma flagTratamiento flagRecomendacion flagGravedad flagAdulto flagPadre flagMadre flagHijo flagHermano flagAbuelo flagTio flagSobrino flagPrimo flagDiagnostico flagPersonajeDe flagContar)))
            (format t "~{~a~^ ~}~%" (handle-flag (first resp) indices input))
            (format t "~{~a~^ ~}~%" (build-response-from-resp resp indices input)))))))


(defun eliza-loop ()
(format t "Hola, soy Eliza. Ingresa tu consulta.~%")
(loop
    (format t "~%> ")
    (let ((line (read-line *query-io* nil nil)))
    (when (null line) (return))
    (let ((tokens (clean-and-tokenize line)))
        (cond
        ((or (string= (first tokens) "adios")
            (string= (first tokens) "bye"))
        (format t "Adios.~%")
        (return))
        (t (respond-to tokens)))))))
