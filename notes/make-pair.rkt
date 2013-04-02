;; (make-pair x y)
;; (first pair)
;; (second pair)

;; list
(define make-pair
  (lambda (x y)
    (list x y)))

(define first car)
(define second cadr)

(first (make-pair 1 2))
(second (make-pair 1 2))

;; vector
(define make-pair
  (lambda (x y)
    (vector x y)))

(define first
  (lambda (vec)
    (vector-ref vec 0)))

(define second
  (lambda (vec)
    (vector-ref vec 1)))

(first (make-pair 1 2))
(second (make-pair 1 2))

;; pairs
(define make-pair cons)
(define first car)
(define second cdr)

(first (make-pair 1 2))
(second (make-pair 1 2))

;; selector
(define make-pair
  (lambda (x y)
    (lambda (selector)
      (if selector x y))))

(define first 
  (lambda (selector)
    (selector #t)))

(define second
  (lambda (selector)
    (selector #f)))

(first (make-pair 1 2))
(second (make-pair 1 2))

;;  message passing
(define make-pair
  (lambda (x y)
    (lambda (msg)
      (cond ((eq? msg 'first) x)
            ((eq? msg 'second) y)))))

(define first
  (lambda (p)
    (p 'first)))

(define second
  (lambda (p)
    (p 'second)))

(first (make-pair 1 2))
(second (make-pair 1 2))

;; functions
(define make-pair
  (lambda (x y)
    (lambda (f)
      (f x y))))

(define first
  (lambda (p)
    (p (lambda (a b) a))))

(define second
  (lambda (p)
    (p (lambda (a b) b))))

(first (make-pair 1 2))
(second (make-pair 1 2))
