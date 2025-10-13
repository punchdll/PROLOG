# La Biblioteca Nacional tiene el libro "Don Quijote de la Mancha".

# Constante de individuo: Biblioteca nacional, Don Quijote de la Mancha.
# Relación (Binaria): Tiene el libro.
# tiene(x, y).


tiene(biblioteca_nacional, don_quijote_de_la_mancha).

# Todos los libros en la Biblioteca Nacional están catalogados.

# Constante de individuo: Biblioteca nacional
# Variables de individuo: Libros
# Cuantificadores: Universal(∀)
#libro(x)
#∀x(libro(x) ⟶ catalogado(x))

libro(Don Quijote de la mancha).
catalogado(X) :- libro(X).

#3. Existen libros que están en más de una biblioteca.

# Variables de individuo: Libros, Biblioteca
# Cuantificadores: Existencial(∃)
#libro(x)
#∀∃(libro(x) ^ tiene(y,x) ^ tiene(z, x)).

existe_en_mas_de_una(X) :- libro(X), tiene(Y,X), tiene(Z,X), Z/==Y.

#4. Si un libro es raro, entonces no se puede prestar.
# Variables de individuo: Libros
#Propiedades: raro, no se puede prestar
# Cuantificadores: Universal(∀)
#libro(X)
#raro(X)
#∀x((libro(X) ^ raro(X)) ⟶ no_se_puede_prestar(X))

no_se_puede_prestar(X) :- libro(X), raro (X).

#5. La Biblioteca Central tiene más de 10,000 libros.
# Constantes de individuo: Biblioteca Central


