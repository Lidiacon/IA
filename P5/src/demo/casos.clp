(deftemplate usuario "Datos sobre el usuario. Serán rellenados desde Java"
	(slot nick)
    (slot edad)
    (slot aficiones)
    (slot prefPrecio)
    (slot dispositivo)
)

(deftemplate app "Datos sobre la app. Serán rellenados desde Java"
	(slot nombre)
    (slot precio)
    (slot genero)
    (slot tematica)
    (slot edad)
    (slot SO)
)

(defrule disponibilidad "Comprueba si el dispositivo y la app son compatibles"
    (usuario (dispositivo ?d1))
    (app (SO ?d2))
    (test (eq ?d1 ?d2))
    =>
    (printout t (app(nombre ?n))))

(defrule coste "Comprueba si la app está en el rango de precios del usuario"
    (usuario (prefPrecio ?p1))
    (app (precio ?p2))
    (test (?p1 >= ?p2))
    =>
    (printout t (app(nombre ?n))))