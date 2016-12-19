

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

(deffacts inicio
    (usuario (nick juan) (edad 15) (aficiones fantasia) (prefPrecio 10) (dispositivo android))
    (usuario (nick rosa) (edad 25) (aficiones scifi) (prefPrecio 20) (dispositivo ios))
    (usuario (nick apryl) (edad 5) (aficiones slice) (prefPrecio 5) (dispositivo win))
    (usuario (nick evaristo) (edad 47) (aficiones scifi) (prefPrecio 50) (dispositivo android))
    (usuario (nick herminigilda) (edad 62) (aficiones scifi) (prefPrecio 200) (dispositivo ios))
    (app (nombre doomand) (precio 50) (genero accion) (tematica scifi) (edad adulto) (SO android))
    (app (nombre undertale) (precio 10)(genero rpg)(tematica fantasia) (edad todos) (SO android))
    (app (nombre doomos) (precio 50) (genero accion) (tematica scifi) (edad adulto) (SO ios))
    (app (nombre doomwin) (precio 50) (genero accion) (tematica scifi) (edad adulto) (SO win))
    (app (nombre transistor) (precio 20) (genero rpg) (tematica scifi) (edad todos) (SO ios))
    (app (nombre meatboy) (precio 5) (genero plataformas) (tematica fantasia) (edad infantil) (SO win))
    (app (nombre pidgeonfantasy) (precio 200) (genero rpg) (tematica slice) (edad todos) (SO ios)))

(defrule disponibilidad "Comprueba si el dispositivo y la app son compatibles"
    (usuario (nick ?n)(dispositivo ?d1))
    (app (nombre ?na)(SO ?d2))
    (test (eq ?d1 ?d2))
    =>
    (assert (disponibilidad ?n ?na)))

(defrule coste "Comprueba si la app está en el rango de precios del usuario"
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
(reset)
(run)
(facts)
