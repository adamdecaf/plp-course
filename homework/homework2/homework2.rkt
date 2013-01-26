;;
;; FILE:     homework2.rkt
;; AUTHOR:   Adam Shannon
;; DATE:     01/26/2013
;; COMMENT:  Homework code
;;
;; MODIFIED: 01/26/2013
;; CHANGE:   First commit of code.
;;

; 1/500th for every foot above sea-level
(define (candy-temperature temp alt)
  (- temp (exact->inexact(/ alt 500))))


; homework = 35%
; quizzes = 35%
; tests = 30%
(define (grade homework quizzes tests)
  (+ (* 0.35 homework) (* 0.35 quizzes) (* 0.3 tests)))


; let a = base, b = distance up wall, c = ladder length
; find b: sqrt(c2 - a2)
(define (ladder-height ladder-length base)
  (sqrt (- (expt ladder-length 2) (expt base 2))))


; Floating point sucks, write a realistic compare method
(define *epsilon* 0.1)
(define (in-range? a b)
  (<= (abs (- a b)) *epsilon*))


; Given any list return true iff length=2, the first element is a symbol, and the second is a string
(define (string-binding? l)
  (cond ((not (list? l)) #f)
        ((not (= (length l) 2)) #f)
        ((not (symbol? (car l))) #f)
        ((not (string? (car (cdr l)))) #f)
        (else #t)))
