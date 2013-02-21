;;
;; FILE:     homework5.rkt
;; AUTHOR:   Adam Shannon
;; DATE:     02/20/2013
;; COMMENT:  Homework code
;;
;; MODIFIED: 02/20/2013
;; CHANGE:   First commit of code.
;;

;; flatten
(define flatten
  (lambda (lst)
    (if (null? lst)
        '()
        (append (flatten-helper (car lst))
                (flatten (cdr lst))))))

(define flatten-helper
  (lambda (numexp)
    (if (number? numexp)
        (list numexp)
        (flatten numexp))))

;; (all-positive? lst)
(define all-positive?
  (lambda (lst)
    (all-positive-helper (flatten lst) #t)))

(define all-positive-helper
  (lambda (lst cond)
        (if (null? lst)
            cond
            (all-positive-helper (cdr lst) (and (positive? (car lst)) cond)))))

;; (reject f lst)
(define reject
  (lambda (f lst)
    (if (null? lst)
        '()
        (reject-helper f (flatten lst) '()))))

(define reject-helper
  (lambda (f lst acc)
    (if (null? lst)
        acc
        (if (f (car lst))
            (reject-helper f (cdr lst) acc)
            (reject-helper f (cdr lst) (cons (car lst) acc))))))


;; (inject initial-value f lon)
(define inject
  (lambda (init f lst)
    (if (null? lst)
        init
        (inject-helper f lst init))))
    
(define inject-helper
  (lambda (f lst total)
    (if (null? lst)
        total
        (f (car lst) (inject-helper f (cdr lst) total)))))

;; contains helper
(define contains? 
  (lambda (mem lst)
    (if (null? lst) #f
        (or (eq? mem (car lst)) (contains? mem (cdr lst))))))

;; (uniq s-list)
(define uniq
  (lambda (lst)
    (if (null? lst)
        '()
        (uniq-helper lst '()))))

(define uniq-helper
  (lambda (lst acc)
    (if (null? lst)
        acc
        (if (contains? (car lst) acc)
            (uniq-helper (cdr lst) acc)
            (uniq-helper (cdr lst) (append acc (car lst)))))))

;; list-ref shortcuts
(define first
  (lambda (l)
    (list-ref l 0)))

(define second
  (lambda (l)
    (list-ref l 1)))

(define third
  (lambda (l)
    (list-ref l 2)))

(define identity (lambda (x) x))

;; (prefix->infix binary-exp) 
;; binary-exp ::= op | binary-exp | binary-exp
(define prefix->infix
  (lambda (exp)
    (list
     (quote-expr (second exp))
     (identity (first exp))
     (quote-expr (third exp)))))

(define quote-expr
  (lambda (exp)
    (list
     (if (list? (second exp))
         (quote-expr (second exp))
         (second exp))
     (identity (first exp))
     (if (list? (third exp))
         (quote-expr (third exp))
         (third exp)))))
