(deffacts inicio
    (dd juan maria rosa m)
    (dd juan maria luis h)
    (dd jose laura pilar m)
    (dd luis pilar miguel h)
    (dd miguel isabel jaime h))

(defrule padre
    (dd ?x ? ?y ?)
    =>
    (assert (padre ?x ?y)))

(defrule madre
    (dd ? ?x ?y ?)
    =>
    (assert (madre ?x ?y)))

(defrule hijo
    (dd ?y ? ?x h)
    (dd ? ?y ?x h)    
    =>
    (assert (hijo ?x ?y)))

(defrule hija
    (dd ?y ? ?x m)
    (dd ? ?y ?x m)    
    =>
    (assert (hija ?x ?y)))

(defrule hermano
    (dd ?p ?m ?x h)
    (dd ?p ?m ?y ?)
    =>
    (assert (hermano ?x ?y)))

(defrule hermana
    (dd ?p ?m ?x m)
    (dd ?p ?m ?y ?)
    =>
    (assert (hermana ?x ?y)))

(defrule abuelo
    (padre ?x ?h)
    (padre ?h ?y)
    ;falta poner (madre ?h ?y) pero no sé usar el or
    =>
    (assert (abuelo ?x ?y)))

(defrule abuela
    (madre ?x ?h)
    (padre ?h ?y)
    ;aquí más de lo mismo
    =>
    (assert (abuela ?x ?y)))

(defrule primo
    (hermana ?t ?pm)
	(hermano ?t ?pm)
    (hijo ?x ?pm)
    (hija ?x ?pm)
    (hijo ?y ?t)
    =>
    (assert (primo ?x ?y)))

(defrule prima
    (hermana ?t ?pm)
	(hermano ?t ?pm)
    (hijo ?x ?pm)
    (hija ?x ?pm)
    (hija ?y ?t)
    =>
    (assert (prima ?x ?y)))


(reset)
(run)
(facts)