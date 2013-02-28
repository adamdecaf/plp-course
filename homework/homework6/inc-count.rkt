;
; written to the concrete data type, a list of symbol/integer pairs
;

(define inc-count
  (lambda (sym counters)
    (if (null? counters)
        (list (cons sym 1))
        (if (eq? sym (caar counters))
            (cons (cons sym (+ 1 (cdar counters)))
                  (cdr counters))
            (cons (car counters)
                  (inc-count sym (cdr counters)))))))

;
; written to the abstract data type, a list of counters
;

(define inc-count
  (lambda (sym counters)
    (if (null? counters)
        (list (make-counter sym 1))
        (if (counter-for? sym (car counters))
            (cons (inc-counter (car counters))
                  (cdr counters))
            (cons (car counters)
                  (inc-count sym (cdr counters)))))))

;
; syntax procedures the abstract data type "counter"
;

(define make-counter cons)
(define symbol-of    car)
(define count-of     cdr)

(define counter-for?
  (lambda (sym pair)
    (eq? sym (symbol-of pair))))

(define inc-counter
  (lambda (counter)
    (make-counter (symbol-of counter)
                  (+ 1 (count-of counter)))))

(define character-counts '((a . 1) (b . 6) (c . 2) (d . 2) (e . 1)))
;(inc-count 'c character-counts)
;(inc-count 'g character-counts)
