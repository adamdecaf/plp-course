;; (map-slist sym->string lst)
;; (map-slist sym->string '((a b) (((b g r) (f r)) ...)
(define map-slist
  (lambda (f lst)
    (if (null? lst)
        '()
        (cons (if (list? (car lst))
                  (map-slist f (car lst))
                  (f (car lst)))
              (map-slist f (cdr lst))))))

(define sym->string
  (lambda (sym)
    sym))

(define mylst '(('a 'b) ((('b 'g 'r) ('f 'r)))))

;; fringe
(define fringe
  (lambda (lst)
    (if (null? lst)
        '()
        (append (fringe-helper (car lst))
                (fringe (cdr lst))))))

(define fringe-helper
  (lambda (symexp)
    (if (symbol? symexp)
        (list symexp)
        (fringe symexp))))

;; Facortial
(define factorial
  (lambda (n)
    (if (zero? n)
        1
        (* n (factorial (- n 1))))))

;; Smart Factorial
(define factorial-aps
  (lambda (n)
    (smart-factorial n 1)))

(define smart-factorial
  (lambda (n answer)
    (if (zero? n)
        answer
        (smart-factorial (- n 1)
                         (* n answer)))))

;; (count-occurences s slist)
(define count-occurences-accum
  (lambda (s slist count)
    (if (null? slist)
        count
        (count-occurences-symexp s (car slist)
                                (count-occurences-accum s (cdr slist) count)))))

(define count-occurences-symexp
  (lambda (s symexp count)
    (if (symbol? symexp)
        (if (eq? s symexp) (+ count 1) count)
        (count-occurences-accum s symexp count))))

(define count-occurences
  (lambda (s symexp)
    (count-occurences-accum s symexp 0)))

