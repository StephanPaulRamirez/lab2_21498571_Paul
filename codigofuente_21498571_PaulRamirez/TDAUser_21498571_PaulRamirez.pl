 /*
 TDA User
 especificación

 User(nombre)

 implementacion

 representacion
 nombre (string)
*/

% Constructor:

/*
 Predicado: user(Nombre, User)
 Dominios:
	User: user
        Nombre: string
 Metas: user
 Clausulas:
*/
user(nombre, user) :- user is nombre.
