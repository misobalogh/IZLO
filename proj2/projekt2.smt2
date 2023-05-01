; Riesenie projektu 2 z predmetu IZLO
; Autor: Michal Balogh, xbalog06
; Datum: 01.05.2023
; FIT VUT BRNO

(set-logic NIA)

(set-option :produce-models true)
(set-option :incremental true)

; Deklarace promennych pro vstupy
; ===============================

; Ceny
(declare-fun c1 () Int)
(declare-fun c2 () Int)
(declare-fun c3 () Int)
(declare-fun c4 () Int)
(declare-fun c5 () Int)

; Kaloricke hodnoty
(declare-fun k1 () Int)
(declare-fun k2 () Int)
(declare-fun k3 () Int)
(declare-fun k4 () Int)
(declare-fun k5 () Int)

; Maximalni pocty porci
(declare-fun m1 () Int)
(declare-fun m2 () Int)
(declare-fun m3 () Int)
(declare-fun m4 () Int)
(declare-fun m5 () Int)

; Maximalni cena obedu
(declare-fun max_cena () Int)

; Deklarace promennych pro reseni
(declare-fun n1 () Int)
(declare-fun n2 () Int)
(declare-fun n3 () Int)
(declare-fun n4 () Int)
(declare-fun n5 () Int)
(declare-fun best () Int)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; START OF SOLUTION ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; pocet porci musi byt nezaporny
(assert (and ( >= n1 0) ( >= n2 0) ( >= n3 0) ( >= n4 0) ( >= n5 0)))

; 1. podmienka:
;                     n1*c1 + ... + n5*c5 ≤ max_cena 
(assert (<= (+ (* n1 c1) (* n2 c2) (* n3 c3) (* n4 c4) (* n5 c5)) max_cena))

; 2. podmienka:
;             ∀n1,...,n5, i ∈ {1,...,5}: (0 ≤ ni ≤ mi)
(assert (and (<= n1 m1) (<= n2 m2) (<= n3 m3) (<= n4 m4) (<= n5 m5)))

; optimalne kaloricke hodnoty - premenna 'best'
(assert (= best (+ (* n1 k1) (* n2 k2) (* n3 k3) (* n4 k4) (* n5 k5))))

; 3. podmienka
;                              1.podmienka ∧  2.podmienka                    → kalorie mensie ako best
; ∀p1,...,p5, i ∈ {1,...,5}: ((0 ≤ pi ≤ mi ∧ p1*c1 + ... + p5*c5 ≤ max_cena) → p1k1 + p2k2 + p3k3 + p4k4 + p5k5 ≤ best)
(assert 
  (forall ((p1 Int) (p2 Int) (p3 Int) (p4 Int) (p5 Int))
    (=> (and (<= p1 m1) (<= p2 m2) (<= p3 m3) (<= p4 m4) (<= p5 m5) (>= p1 0) (>= p2 0) (>= p3 0) (>= p4 0) (>= p5 0)
             (<= (+ (* p1 c1) (* p2 c2) (* p3 c3) (* p4 c4) (* p5 c5)) max_cena))
        (<= (+ (* p1 k1) (* p2 k2) (* p3 k3) (* p4 k4) (* p5 k5)) best)
    )
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; END OF SOLUTION ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Testovaci vstupy
; ================

(echo "Test 1.a - ocekavany vystup je sat, promenna best ma hodnotu 34")
(check-sat-assuming (
  (= c1 7) (= c2 3) (= c3 6) (= c4 10) (= c5 8)
  (= k1 5) (= k2 2) (= k3 4) (= k4 7)  (= k5 3)
  (= m1 3) (= m2 2) (= m3 4) (= m4 1)  (= m5 3)
  (= max_cena 50)
))
(get-value (best n1 n2 n3 n4 n5))

(echo "Test 1.b - neexistuje jine reseni nez 34, ocekavany vystup je unsat")
(check-sat-assuming (
  (= c1 7) (= c2 3) (= c3 6) (= c4 10) (= c5 8)
  (= k1 5) (= k2 2) (= k3 4) (= k4 7)  (= k5 3)
  (= m1 3) (= m2 2) (= m3 4) (= m4 1)  (= m5 3)
  (= max_cena 50)
  (not (= best 34))
))

; =========================================================


(echo "Test 2.a - ocekavany vystup je sat, promenna best ma hodnotu 0")
(check-sat-assuming (
  (= c1 7) (= c2 3) (= c3 6) (= c4 10) (= c5 8)
  (= k1 5) (= k2 2) (= k3 4) (= k4 7)  (= k5 3)
  (= m1 3) (= m2 2) (= m3 4) (= m4 1)  (= m5 3)
  (= max_cena 0)
))
(get-value (best n1 n2 n3 n4 n5))

(echo "Test 2.b - neexistuje jine reseni nez 0, ocekavany vystup je unsat")
(check-sat-assuming (
  (= c1 7) (= c2 3) (= c3 6) (= c4 10) (= c5 8)
  (= k1 5) (= k2 2) (= k3 4) (= k4 7)  (= k5 3)
  (= m1 3) (= m2 2) (= m3 4) (= m4 1)  (= m5 3)
  (= max_cena 0)
  (not (= best 0))
))

