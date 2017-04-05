(defrule disponibilidad "Comprueba si el dispositivo y la app son compatibles"
    (object (is-a Usuario)(nombre ?n)(dispositivo ?d))
    (object (is-a App) (nombre ?na)(SO $? ?d $?))
    =>
    (assert (disponibilidad ?n ?na)))

(defrule recomen3a "coincidencia de SO y edad(a)"
    (disponibilidad ?n ?na)
    (object (is-a Usuario)(nombre ?n)(años ?d1))
    (object (is-a App) (nombre ?na)(edad ?d2))
    (test (>= ?d1 18))
    (test (eq ?d2 Adulto))
    =>
    (assert (recomen3 ?n ?na)))	

(defrule recomen3m "coincidencia de SO y edad(m)"
    (disponibilidad ?n ?na)
    (object (is-a Usuario)(nombre ?n)(años ?d1))
    (object (is-a App) (nombre ?na)(edad ?d2))
    (test (>= ?d1 18))
    (test (eq ?d2 Adulto))
    =>
    (assert (recomen3 ?n ?na)))

(defrule recomen3t "coincidencia de SO y edad(todos)"
    (disponibilidad ?n ?na)
    (object (is-a App) (nombre ?na)(edad Todos))
    =>
    (assert (recomen3 ?n ?na)))
	
(defrule recomen2t "coincidencia con tipo"
    (object (is-a Usuario)(nombre ?n)(aficiones $? ?d $?))
    (object (is-a App) (nombre ?na)(tipo ?d))
    (recomen3 ?n ?na)
    =>
    (assert (recomen2 ?n ?na)))

(defrule recomen2g "coincidencia con genero"
    (object (is-a Usuario)(nombre ?n)(aficiones $? ?d $?))
    (object (is-a App) (nombre ?na)(genero ?d))
    (recomen3 ?n ?na)
	=>
    (assert (recomen2 ?n ?na)))

(defrule recomen1 "coincidencia con coste"
    (object (is-a Usuario)(nombre ?n)(precio ?p1))
    (object (is-a App) (nombre ?na)(precio ?p2))
    (test (>= ?p1 ?p2))
    (recomen2 ?n ?na)
    =>
    (assert (recomen1 ?n ?na)))

(defrule recom
	(object (is-a Usuario)(OBJECT ?USER)(nombre ?n)(recom $?list))
	(recomen1 ?n ?na)
	(object (is-a App)(OBJECT ?app)(nombre ?na))
	(test (not (member$ ?app $?list)))
	=>
	(slot-insert$ ?USER recom (+ 1 (length$ ?list)) ?app))
	