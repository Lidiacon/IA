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
    (dd ?p ?m ?x h)  
    =>
    (assert (hijo ?x ?p))
    (assert (hijo ?x ?m)))

(defrule hija
    (dd ?p ?m ?x m)   
    =>
    (assert (hija ?x ?p))
    (assert (hija ?x ?m)))

(defrule hermano
    (dd ?p ?m ?x h)
    (dd ?p ?m ?y ?)
    (test (neq ?x ?y))
    =>
    (assert (hermano ?x ?y)))

(defrule hermana
    (dd ?p ?m ?x m)
    (dd ?p ?m ?y ?)
    (test (neq ?x ?y))
    =>
    (assert (hermana ?x ?y)))

(defrule abueloP
    (padre ?x ?h)
    (padre ?h ?y)
        =>
    (assert (abuelo ?x ?y)))
    
(defrule abueloM
	(padre ?x ?h)
    (madre ?h ?y)
        =>
    (assert (abuelo ?x ?y)))

(defrule abuelaP
    (madre ?x ?h)
    (padre ?h ?y)
    =>
    (assert (abuela ?x ?y)))

(defrule abuelaM
    (madre ?x ?h)
    (madre ?h ?y)
    =>
    (assert (abuela ?x ?y)))

(defrule primoP
    (padre ?p ?y)
    (hermano ?p ?t)
    (hijo ?x ?t)
    =>
    (assert (primo ?x ?y)))

(defrule primoM
    (madre ?m ?y)
    (hermana ?m ?t)
    (hijo ?x ?t)
    =>
    (assert (primo ?x ?y)))

(defrule primaP
    (padre ?p ?y)
    (hermano ?p ?t)
    (hija ?x ?t)
    =>
    (assert (prima ?x ?y)))

(defrule primaM
    (madre ?m ?y)
    (hermana ?m ?t)
    (hija ?x ?t)
    =>
    (assert (prima ?x ?y)))

;revisar ascendientes
(defrule ascendienteP
    (padre ?x ?y)
    => 
    (assert (ascendiente ?x ?y)))

(defrule ascendienteAP
    )

(defrule ascendienteM
    (madre ?x ?y)
    =>
    (assert (ascendiente ?x ?y)))

(defrule ascendienteAM
    (ascendiente ?x ?y)
    (madre ?z ?x)
    =>
    (assert (ascendiente ?z ?y)))    

(reset)
(run)
(facts)
