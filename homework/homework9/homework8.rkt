;;
;; FILE:     homework8.rkt
;; AUTHOR:   Adam Shannon
;; DATE:     04/05/2013
;; COMMENT:  Homework code
;;
;; MODIFIED: 04/05/2013
;; CHANGE:   First commit of code.
;;
(require racket/vector)

;; record via a vector
;(record <field-name> <field-name> ...)
;(record-put <record> <field> <value>)
;(record-get <record> <field>)

(define vmap 
  (lambda (f vec)
    (vmap-helper f vec #())))

(define vmap-helper
  (lambda (f vec acc)
    (if (zero? (vector-length vec))
        acc
        (vmap-helper f 
                     (vector-drop vec 1) 
                     (vector-append acc (vector (f (vector-ref vec 0))))))))

; (vmap (lambda (e) (+ e 1)) #(1 2 3 4))

(define record
  (lambda syms
    (vmap (lambda (sym) (list sym 0)) (list->vector syms))))

(define rec (record 'first 'last 'middle))

(define record-put
  (lambda (rec sym value)
    (vmap (lambda (elm)
            (if (eq? (car elm) sym)
                (list sym value)
                elm)) rec)))

;(record-put rec 'first "adam")

(define record-get
  (lambda (rec sym)
    (record-get-helper rec sym (record sym))))

(define record-get-helper
  (lambda (rec sym acc)
    (if (zero? (vector-length rec))
        (car (vector-ref acc 0))
        (vmap (lambda (elm)
                (if (eq? (car elm) sym)
                    (record-get-helper 
                     (vector-drop rec 1)
                     sym 
                     (record-put acc sym (cadr elm))))) 
              rec))))

(define recc (record-put (record 'name) 'name "adam"))
(record-get recc 'name)

;; 3) run-length
(define run-length-encode
  (lambda (lst)
    (run-length-helper (cdr lst) (car lst) 1)))

(define run-length-helper
  (lambda (lst curr count)
    (if (null? lst)
        (cons curr (if (= count 1) '() count))
        (if (eq? (car lst) curr)
            (run-length-helper (cdr lst) curr (+ count 1))
            (cons (cons curr (if (= count 1) '() count))
                  (run-length-helper (cdr lst) (car lst) 1))))))

(run-length-encode '(1 1 1 1 2))
(run-length-encode '(o o o o o o o p p s))

;; Boom
;<exp> ::= <number>
;         | ( <exp> <operator> <exp> )
;<operator> ::= + | - | * | / | %

;; boom?, boom/exp?, boom/oper?, boom/left, boom/oper, boom/right
(define boom/left car)
(define boom/oper cadr)
(define boom/right caddr)

(eq? (boom/left '(12 * 20)) 12)
(eq? (boom/oper '(12 * 20)) '*)
(eq? (boom/right '(12 * 20)) 20)

(define boom? 
  (lambda (exp)
    (if (null? exp)
        #f
        (boom/exp? exp))))
        
(define boom/exp?
  (lambda (exp)
    (or (number? exp)
        (and (eq? (length exp) 3)
             (boom/exp? (boom/left exp))
             (boom/oper? (boom/oper exp))
             (boom/exp? (boom/right exp))))))

(define boom/oper?
  (lambda (opt)
    (or (eq? opt '+)
        (eq? opt '-)
        (eq? opt '*)
        (eq? opt '/)
        (eq? opt '%))))

(boom/oper? '+)
(boom/oper? '-)
(boom/oper? '*)
(boom/oper? '/)
(boom/oper? '%)

(boom/exp? 12)
(boom/exp? '(12 % 100))
(boom/exp? '((1 * 1) * (5 / (4 % 2))))

;; (boom/eval exp)
(define boom/eval
  (lambda (exp)
    (if (not (boom? exp))
        #f
        (boom-eval-helper exp))))

(define boom/sym->oper
  (lambda (sym)
    (cond ((eq? sym '+) +)
          ((eq? sym '-) -)
          ((eq? sym '*) *)
          ((eq? sym '/) /)
          ((eq? sym '%) modulo))))

(define boom-eval-helper
  (lambda (exp)
    (if (number? exp)
        exp
        ((boom/sym->oper (boom/oper exp))
         (if (boom/exp? (boom/left exp))
             (boom-eval-helper (boom/left exp))
             (boom/left exp))
         (if (boom/exp? (boom/right exp))
             (boom-eval-helper (boom/right exp))
             (boom/right exp))
         ))))
  
(boom/eval 2)
(boom/eval '(2 + 4))
(boom/eval '((2 * 14) + (4 - 6)))
(boom/eval '((8 % 3) + (4 * (6 - (20 / 10)))))
