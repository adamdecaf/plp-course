;;
;; FILE:     homework2.rkt
;; AUTHOR:   Adam Shannon
;; DATE:     01/26/2013
;; COMMENT:  Homework code
;;
;; MODIFIED: 01/26/2013
;; CHANGE:   First commit of code.
;;

;; Problem 1
(define softmax
    (lambda (x y)
      (log (+ (exp x) (exp y)))))


;; Problem 2
(define (sum-of-apps f x y)
  (+ (f x) (f y)))

;; Helpers
(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

;; Problem 3
;; Old
;; (define (candy-temperature temp alt)
;;    (- temp (exact->inexact(/ alt 500))))
(define candy-temperature-of
  (lambda (temp)
    (lambda (alt)
      (- temp (exact->inexact(/ alt 500))))))

;; Problem 4
;; Old
;; (define (in-range? a b)
;;   (<= (abs (- a b)) *epsilon*))
(define in-range-of?
  (lambda (epsilon)
    (lambda (a b)
      (<= (abs (- a b)) epsilon))))

;; Problem 5
(define sequence
  (lambda (start finish)
    (if (> start finish)
        '()
        (cons start (sequence (+ start 1) finish)))
    ))

(define softmax-var
  (lambda x
    (if (null? x)
        0
        (softmax (car x) (apply softmax-var (cdr x))))))
        ;;(+ (car x) (apply plus (cdr x))) )))
