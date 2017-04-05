(mapclass App)
(mapclass Desarrollador)
(mapclass SystemO)
(mapclass Usuario)
(mapclass :THING)

(deftemplate AppJ "Datos de las apps que introduciremos desde Jess"
    (slot desarrollado_por)
    (slot edad)
    (slot nombre)
    (slot num_descargas)
    (slot precio)
    (slot genero)
    (slot puntuacion)
    (multislot SO)
    (slot tipo))

(deftemplate DesarrolladorJ "Datos de los desarrolladores que introduciremos desde Jess"
    (multislot hicieron)
    (slot nombre))

(deftemplate SystemOJ "Datos de los SO que introduciremos desde Jess"
    (slot nombre))

(deffacts ini "Datos iniciales de SO y desarrolladores"
    (SystemOJ (nombre "Windows"))
    (SystemOJ (nombre "Android"))
    (SystemOJ (nombre "iOs"))
    (DesarrolladorJ (nombre "Disney"))
    (DesarrolladorJ (nombre "Electronic_Arts"))
    (DesarrolladorJ (nombre "Giant_Games"))
    (DesarrolladorJ (nombre "Lucas_Arts"))
    (DesarrolladorJ (nombre "Nintendo"))
    (DesarrolladorJ (nombre "Viajacon")))

(defrule cargarSys "Transforma los SO de Jess en instancias Protege de la misma clase"
	(SystemOJ (nombre ?n))
	=>
	(make-instance of SystemO (nomSO ?n)))

(defrule cargarDes "Transforma los desarrolladores de Jess en instancias Protegede la misma clase"
	(DesarrolladorJ (nombre ?n))
	=>
	(make-instance of Desarrollador (nombre ?n)))

(deffacts appsini "Datos iniciales de Apps"
	(AppJ (desarrollado_por "Nintendo")(edad Todos)(nombre "Mario")(num_descargas 20000)(precio 20.5)(puntuacion 4)(SO "iOs" "Android")(tipo Juego)(genero Plataformas))
    (AppJ (desarrollado_por "Disney")(edad Todos)(nombre "ElsaContesta")(num_descargas 999999999)(precio 50.0) (puntuacion 1)(SO "iOs" "Windows")(tipo Consulta))
    (AppJ (desarrollado_por "Nintendo")(edad Adulto)(nombre "Metroid")(num_descargas 2222220)(precio 10.0) (puntuacion 5)(SO "iOs" "Android")(tipo Juego)(genero Rpg))
    (AppJ (desarrollado_por "Electronic_Arts")(edad Adulto)(nombre "CeroComida")(num_descargas 11111110)(precio 25.0) (puntuacion 4)(SO "Android")(tipo Cocina))
    (AppJ (desarrollado_por "Giant_Games")(edad Adulto)(nombre "Transistor")(num_descargas 0)(precio 20.0) (puntuacion 5)(SO "iOs" "Windows" "Android")(tipo Juego)(genero Accion))
    (AppJ (desarrollado_por "Viajacon")(edad Infantil)(nombre "Conoce_Paris")(num_descargas 20)(precio 120.0) (puntuacion 1)(SO "iOs")(tipo Viaje))
    (AppJ (desarrollado_por "Electronic_Arts")(edad Todos)(nombre "PreguntasShepard")(num_descargas 1240)(precio 20.0) (puntuacion 2)(SO "Windows")(tipo Consulta))
    (AppJ (desarrollado_por "Giant_Games")(edad Todos)(nombre "Bastion")(num_descargas 222450)(precio 25.0) (puntuacion 5)(SO "Windows")(tipo Juego)(genero Accion))
    (AppJ (desarrollado_por "Viajacon")(edad Todos)(nombre "CocinaConNosotros")(num_descargas 0)(precio 0.0)(puntuacion 3)(SO "iOs")(tipo Cocina))
    (AppJ (desarrollado_por "Lucas_Arts")(edad Todos)(nombre "Monkey_Island")(num_descargas 0)(precio 0.4)(puntuacion 5)(SO "iOs" "Windows")(tipo Juego))
    (AppJ (desarrollado_por "Electronic_Arts")(edad Todos)(nombre "Sims_42")(num_descargas 999999999)(precio 20.0) (puntuacion 1)(SO "iOs" "Windows")(tipo Juego))
    (AppJ (desarrollado_por "Nintendo")(edad Todos)(nombre "Fire_Emblem:_Heroes")(num_descargas 0)(precio 0.0) (puntuacion 5)(SO "iOs" "Android")(tipo Juego)(genero Rpg))
    (AppJ (desarrollado_por "Disney")(edad Todos)(nombre "Kingdom_Hearts")(num_descargas 0)(precio 20.0) (puntuacion 4)(SO "iOs" "Android")(tipo Juego)(genero Rpg))
    (AppJ (desarrollado_por "Giant_Games")(edad Adulto)(nombre "Transistor")(num_descargas 0)(precio 20.0) (puntuacion 5)(SO "iOs" "Windows" "Android")(tipo Juego)(genero Accion))
    (AppJ (desarrollado_por "Disney")(edad Infantil)(nombre "La_gran_guia_de_pato_Donald_para_el_viajero_experto")(num_descargas 0)(precio 10.0) (puntuacion 0)(SO "iOs")(tipo Viaje))
    (AppJ (desarrollado_por "Electronic_Arts")(edad Todos)(nombre "Comida_de_Andromeda")(num_descargas 0)(precio 20.0) (puntuacion 0)(SO "iOs")(tipo Cocina))
    (AppJ (desarrollado_por "Disney")(edad Infantil)(nombre "Mickey:_the_magic_mirror")(num_descargas 0)(precio 3.0) (puntuacion 3)(SO "Windows")(tipo Juego)(genero Plataformas))
    (AppJ (desarrollado_por "Viajacon")(edad Todos)(nombre "ViajeConNosotros")(num_descargas 0)(precio 0.0)(puntuacion 3)(SO "iOs")(tipo Viaje)))
	
(defrule cargaApp 
	(AppJ (desarrollado_por ?d)(edad ?e)(nombre ?na)(num_descargas ?nd)(precio ?p)(puntuacion ?pu)(tipo ?t))
	(object (is-a Desarrollador) (OBJECT ?DES) (nombre ?d))
	=>
	(make-instance of App (desarrollado_por ?DES)(edad ?e)(nombre ?na)(num_descargas ?nd)(precio ?p)(puntuacion ?pu)(tipo ?t)))
	
(defrule SysApp
	(AppJ (nombre ?na)(SO $? ?so $?))
	(object (is-a App)(nombre ?na)(SO $?syo)(OBJECT ?A))
	(object (is-a SystemO)(nomSO ?so)(OBJECT ?SYS))
	(test (not (member$ ?SYS ?syo)))
	=>
	(slot-insert$ ?A SO 1 ?SYS))

(defrule jerarquizaCocina
	(object (is-a App) (OBJECT ?APP)(tipo Cocina))
	(object (is-a :STANDARD-CLASS) (:NAME "Cocina") (:DIRECT-INSTANCES $?list))
	=>
	(slot-set "Cocina" :DIRECT-INSTANCES
	(insert$ ?list (+ 1 (length$ ?list)) ?APP)))
	
(defrule jerarquizaConsulta
	(object (is-a App) (OBJECT ?APP)(tipo Consulta))
	(object (is-a :STANDARD-CLASS) (:NAME "Consulta") (:DIRECT-INSTANCES $?list))
	=>
	(slot-set "Consulta" :DIRECT-INSTANCES
	(insert$ ?list (+ 1 (length$ ?list)) ?APP)))

(defrule jerarquizaViaje
	(object (is-a App) (OBJECT ?APP)(tipo Viaje))
	(object (is-a :STANDARD-CLASS) (:NAME "Viaje") (:DIRECT-INSTANCES $?list))
	=>
	(slot-set "Viaje" :DIRECT-INSTANCES
	(insert$ ?list (+ 1 (length$ ?list)) ?APP)))
	
(defrule jerarquizaJuego
	(object (is-a App) (OBJECT ?APP)(tipo Juego)(nombre ?n))
	(AppJ (nombre ?n) (genero nil))
	(object (is-a :STANDARD-CLASS) (:NAME "Juego") (:DIRECT-INSTANCES $?list))
	=>
	(slot-set "Juego" :DIRECT-INSTANCES
	(insert$ ?list (+ 1 (length$ ?list)) ?APP)))
	
(defrule jerarquizaAccion
	(object (is-a App) (OBJECT ?APP)(tipo Juego) (nombre ?n))
	(AppJ (nombre ?n) (genero Accion))
	(object (is-a :STANDARD-CLASS) (:NAME "Juego") (:DIRECT-INSTANCES $?listT))
	(object (is-a :STANDARD-CLASS) (:NAME "Accion") (:DIRECT-INSTANCES $?listG))
	=>
	(slot-set "Juego" :DIRECT-INSTANCES
	(insert$ ?listT (+ 1 (length$ ?listT)) ?APP))
	(slot-set "Accion" :DIRECT-INSTANCES
	(insert$ ?listG (+ 1 (length$ ?listG)) ?APP)))
	
(defrule jerarquizaPlataformas
	(object (is-a App) (OBJECT ?APP)(tipo Juego) (nombre ?n))
	(AppJ (nombre ?n) (genero Plataformas))
	(object (is-a :STANDARD-CLASS) (:NAME "Juego") (:DIRECT-INSTANCES $?listT))
	(object (is-a :STANDARD-CLASS) (:NAME "Plataformas") (:DIRECT-INSTANCES $?listG))
	=>
	(slot-set "Juego" :DIRECT-INSTANCES
	(insert$ ?listT (+ 1 (length$ ?listT)) ?APP))
	(slot-set "Plataformas" :DIRECT-INSTANCES
	(insert$ ?listG (+ 1 (length$ ?listG)) ?APP)))
	
(defrule jerarquizaRPG
	(object (is-a App) (OBJECT ?APP)(tipo Juego) (nombre ?n))
	(AppJ (nombre ?n) (genero Rpg))
	(object (is-a :STANDARD-CLASS) (:NAME "Juego") (:DIRECT-INSTANCES $?listT))
	(object (is-a :STANDARD-CLASS) (:NAME "Rpg") (:DIRECT-INSTANCES $?listG))
	=>
	(slot-set "Juego" :DIRECT-INSTANCES
	(insert$ ?listT (+ 1 (length$ ?listT)) ?APP))
	(slot-set "Rpg" :DIRECT-INSTANCES
	(insert$ ?listG (+ 1 (length$ ?listG)) ?APP)))

(defrule disponibilidad "Comprueba si el dispositivo y la app son compatibles"
    (object (is-a Usuario)(nombre ?n)(dispositivo ?d))
    (AppJ (nombre ?na)(SO $? ?d $?))
    =>
    (assert (disponibilidad ?n ?na)))

(defrule coste "Comprueba si la app está en el rango de precios del usuario"
    (object (is-a Usuario)(nombre ?n)(precio ?p1))
    (AppJ (nombre ?na)(precio ?p2))
    (test (>= ?p1 ?p2))
    =>
    (assert (coste ?n ?na)))

(defrule edada "comprueba el pegi"
    (object (is-a Usuario)(nombre ?n)(años ?d1))
    (AppJ (nombre ?na)(edad ?d2))
    (test (>= ?d1 18))
    (test (eq ?d2 Adulto))
    =>
    (assert (adulto ?n ?na)))

(defrule edadm "comprueba el pegi"
    (object (is-a Usuario)(nombre ?n)(años ?d1))
    (AppJ (nombre ?na)(edad ?d2))
    (test (< ?d1 18))
    (test (eq ?d2 Infantil))
    =>
    (assert (menor ?n ?na)))

(defrule tipo "comprueba el tipo"
    (object (is-a Usuario)(nombre ?n)(aficiones $? ?d $?))
    (AppJ (nombre ?na)(tipo ?d))
    =>
    (assert (tipo ?n ?na)))

(defrule gen "comprueba el genero"
    (object (is-a Usuario)(nombre ?n)(aficiones $? ?d $?))
    (AppJ (nombre ?na)(genero ?d))
    =>
    (assert (gen ?n ?na)))

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
    (AppJ (nombre ?na)(edad Todos))
    =>
    (assert (recomen3 ?n ?na)))

(defrule recomen2t "coincidencia con tipo"
    (tipo ?n ?na)
    (recomen3 ?n ?na)
    =>
    (assert (recomen2 ?n ?na)))

(defrule recomen2g "coincidencia con genero"
    (gen ?n ?na)
    (recomen3 ?n ?na)
	=>
    (assert (recomen2 ?n ?na)))

(defrule recomen1 "coincidencia con coste"
	(coste ?n ?na)
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
	