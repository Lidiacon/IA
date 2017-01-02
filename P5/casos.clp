
;datos de usuario
(deftemplate usuario "Datos sobre el usuario. Ser�n rellenados desde Java"
	(slot nick)
    (slot edad)
    (slot aficiones)
    (slot prefPrecio)
    (slot dispositivo)
)
;datos de app
(deftemplate app "Datos sobre la app. Ser�n rellenados desde Java"
	(slot nombre)
    (slot precio)
    (slot genero)
    (slot tematica)
    (slot edad)
    (slot SO)
)
;hechos analizables
(deffacts inicio
    (usuario (nick herminigilda) (edad 62) (aficiones scifi) (prefPrecio 200) (dispositivo ios))
    (app (nombre doomand) (precio 50) (genero accion) (tematica scifi) (edad adulto) (SO android))
    (app (nombre undertale) (precio 10)(genero rpg)(tematica fantasia) (edad todos) (SO android))
    (app (nombre doomos) (precio 50) (genero accion) (tematica scifi) (edad adulto) (SO ios))
    (app (nombre doomwin) (precio 50) (genero accion) (tematica scifi) (edad adulto) (SO win))
    (app (nombre transistor) (precio 20) (genero rpg) (tematica scifi) (edad todos) (SO ios))
    (app (nombre meatboy) (precio 5) (genero plataformas) (tematica fantasia) (edad infantil) (SO win))
    (app (nombre pidgeonfantasy) (precio 200) (genero rpg) (tematica slice) (edad todos) (SO ios)))

;diferentes tipos de coincidencia
(defrule disponibilidad "Comprueba si el dispositivo y la app son compatibles"
    (usuario (nick ?n)(dispositivo ?d1))
    (app (nombre ?na)(SO ?d2))
    (test (eq ?d1 ?d2))
    =>
    (assert (disponibilidad ?n ?na)))

(defrule coste "Comprueba si la app est� en el rango de precios del usuario"
    (usuario (nick ?n)(prefPrecio ?p1))
    (app (nombre ?na)(precio ?p2))
    (test (>= ?p1 ?p2))
    =>
    (assert (coste ?n ?na)))

(defrule edada "comprueba el pegi"
    (usuario (nick ?n)(edad ?d1))
    (app (nombre ?na)(edad ?d2))
    (test (>= ?d1 18))
    (test (eq ?d2 adulto))
    =>
    (assert (adulto ?n ?na)))

(defrule edadm "comprueba el pegi"
    (usuario (nick ?n)(edad ?d1))
    (app (nombre ?na)(edad ?d2))
    (test (< ?d1 18))
    (test (eq ?d2 infantil))
    =>
    (assert (menor ?n ?na)))

(defrule tema "comprueba el tema"
    (usuario (nick ?n)(aficiones ?d1))
    (app (nombre ?na)(tematica ?d2))
    (test (eq ?d2 ?d1))
    =>
    (assert (tema ?n ?na)))

;aqu� empieza la verdadera lista de recomendados
(defrule recomen3a "coincidencia de SO y edad(a)"
    (disponibilidad ?n ?na)
    (adulto ?n ?na)
    =>
    (assert (recomen3 ?n ?na)))

(defrule recomen3m "coincidencia de SO y edad(m)"
    (disponibilidad ?n ?na)
    (menor ?n ?na)
    =>
    (assert (recomen3 ?n ?na)))

(defrule recomen3t "coincidencia de SO y edad(todos)"
	(disponibilidad ?n ?na)
    (app (nombre ?na)(edad todos))
    =>
    (assert (recomen3 ?n ?na)))

(defrule recomen2 "coincidencia con tema"
    (tema ?n ?na)
    (recomen3 ?n ?na)
    =>
    (assert (recomen2 ?n ?na)))

(defrule recomen1 "coincidencia con coste"
    (coste ?n ?na)
    (recomen2 ?n ?na)
    =>
    (printout t ?na crlf)
    (assert (recomen1 ?n ?na)))

(reset)
(printout t "Estas son tus recomendaciones" crlf)
(run)


