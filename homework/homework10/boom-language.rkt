;; Boom
; <exp> ::= <number>
;            | ( <unary-operator> <exp> )
;            | ( <exp> <operator> <exp> )
;
; <unary-operator> ::= - | sqrt

;; boom/number?
(define boom/number (lambda (x) x))
(define boom/number? number?)

;; boom accessors
(define boom/left car)
(define boom/oper cadr)
(define boom/right caddr)

;; boom operators
(define boom/oper?
  (lambda (opt)
    (or (eq? opt '+)
        (eq? opt '-)
        (eq? opt '*)
        (eq? opt '/)
        (eq? opt '%))))
 
;; boom unary accessors
(define boom/unary->oper car)
(define boom/unary->exp cadr)

(define boom/unary-oper? 
  (lambda (exp)
    (or (eq? '- exp)
        (eq? 'sqrt exp))))

(define boom/unary?
  (lambda (exp)
    (and (eq? (length exp) 2)
         (boom/unary-oper? (boom/unary->oper exp))
         (boom/exp? (boom/unary->exp exp)))))

(define boom/unary/eval
  (lambda (exp)
    (cond ((eq? (boom/unary->oper exp) 'sqrt)
           (sqrt (boom/eval (boom/unary->exp exp))))
          ((eq? (boom/unary->oper exp) '-)
           (- (boom/eval (boom/unary->exp exp)))))))

;; boom/app?
(define boom/app?
  (lambda (exp)
    (and (eq? (length exp) 3)
             (boom/exp? (boom/left exp))
             (boom/oper? (boom/oper exp))
             (boom/exp? (boom/right exp)))))

;; boom/app/eval
(define boom/sym->oper
  (lambda (sym)
    (lambda (a b)
      (cond ((eq? sym '+) (+ a b))
            ((eq? sym '-) (- a b))
            ((eq? sym '*) (* a b))
            ((eq? sym '/) (/ a b))
            ((eq? sym '%) (modulo a b))))))

(define boom/app/eval
  (lambda (exp)
    ((boom/sym->oper (boom/oper exp))
     (boom/eval (boom/left exp))
     (boom/eval (boom/right exp)))))

;; boom/exp?
(define boom/exp?
  (lambda (exp)
    (and (not (null? exp))
         (or (boom/number? exp)
             (boom/unary? exp)
             (boom/app? exp)))))

;; boom/eval
(define boom/eval
  (lambda (exp)
    (if (boom/exp? exp)
        (cond ((boom/number? exp) exp)
              ((boom/app? exp)
               (boom/app/eval exp))
              ((boom/unary? exp)
               (boom/unary/eval exp)))
        (error "Invalid Statement"))))

;; tests
(display "boom/number? tests\n")
(boom/number? 12)
(not (boom/number? #f))

(display "boom/left, /oper, /right tests\n")
(eq? (boom/left '(12 * 20)) 12)
(equal? (boom/left '((1 * 2) + 100)) '(1 * 2))
(eq? (boom/oper '(12 * 20)) '*)
(eq? (boom/right '(12 * 20)) 20)
(equal? (boom/right '(100 * (1 + 2))) '(1 + 2))

(display "boom/oper? tests\n")
(boom/oper? '+)
(boom/oper? '-)
(boom/oper? '*)
(boom/oper? '/)
(boom/oper? '%)

(display "boom/unary? tests\n")
(boom/unary? '(- 12))
(boom/unary? '(sqrt 12))
(not (boom/unary? '()))
(not (boom/unary? '(12 12)))

(display "boom/unary/eval tests\n")
(eq? (boom/unary/eval '(- 12)) (- 12))
(eq? (boom/unary/eval '(sqrt 4)) 2)

(display "boom/app? tests\n")
(boom/app? '(12 + 100))
(boom/app? '((2 * 14) + (4 - 6)))

(display "boom/app/eval tests\n")
(eq? (boom/app/eval '(10 % 2)) 0)
(eq? (boom/app/eval '(12 + 24)) 36)

(display "boom/exp? tests\n")
(boom/exp? 12)
(boom/exp? '(12 % 100))
(boom/exp? '((1 * 1) * (5 / (4 % 2))))
(boom/exp? '(- 12))
(boom/exp? '(sqrt 12))
(not (boom/exp? '(12)))
(not (boom/exp? '()))

(display "boom/eval tests\n")
(eq? (boom/eval '(- 12)) (- 12))
(eq? (boom/eval '(sqrt 4)) 2)
(eq? (boom/eval 2) 2)
(eq? (boom/eval '(2 + 4)) 6)
(eq? (boom/eval '((2 * 14) + (4 - 6))) 26)
(eq? (boom/eval '((8 % 3) + (4 * (6 - (20 / 10))))) 18)