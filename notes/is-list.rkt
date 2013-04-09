;; write list syntax checker
(define item?
  (lambda (exp)
    (or (symbol? exp)
        (number? exp)
        (string? exp))))

(define llist?
  (lambda (exp)
    (if (null? exp)
        #t
        (and (not (item? exp))
             (item? (car exp))
             (list? (cdr exp))))))

;; testing
(define true? (lambda (e) (eq? #t e)))
(define false? (lambda (e) (not (true? e))))

(true? (llist? '(1 2 3)))
(true? (llist? '(1 3 (4 5))))
(true? (llist? '()))
(false? (llist? 3))

;; list-index
(define list-index
  (lambda (pos lst)
    (cond ((null? lst) '())
          ((zero? pos) (car lst))
          ((list-index (- pos 1) (cdr lst))))))

(eq? 2 (list-index 1 '(1 2 3 4)))
(null? (list-index 5 '(1 2 3 4)))

;; define-datatype for this
;(define-datatype ast-list llist?
;  (empty-list)
;  (cons-list (item (lambda (a) #t))
;             (rest llist?)))