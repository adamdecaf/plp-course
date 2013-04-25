;;
;; FILE:     homework11.rkt
;; AUTHOR:   Adam Shannon
;; DATE:     04/22/2013
;; COMMENT:  Homework code
;;
;; MODIFIED: 04/2/2013
;; CHANGE:   First commit of code.
;;
(load "boom-language.rkt")

;; Problem 1
;; (bindings) -- empty-ff
;; (bind sym value ff) -- extend-ff
;; (look-up env sym) -- apply-ff
(define bindings
  (lambda ()
      '()))

(define bind
  (lambda (sym val ff)
    (append (list (list sym val)) ff)))

(define look-up
  (lambda (ff sym)
    (let ((val (assoc sym ff)))
      (if (null? val)
          (error "not found")
          val))))

(display "Problem 1 tests\n")
(null? (bindings))
(equal? (bind 'foo 2 (bindings)) '((foo 2)))
(equal? (bind 'bar 5 (bind 'foo 2 (bindings))) '((bar 5) (foo 2)))

(define env (bind 'bar 5 (bind 'foo 2 (bindings))))
(equal? (look-up env 'foo) '(foo 2))

;; Problem 2
;; Done in boom-language.rkt
(display "Problem 2 tests\n")
(boom/exp? 'pi)
(boom/exp? 'i)
(not (boom/number? 'e))
(boom/varref? 'e)
(boom/exp? '(pi * (2 * 2)))
(boom/exp? '(2 * e))
(boom/exp? '(2 * (2 * (2 * (2 * (2 * (2 * e)))))))

(define boom/sugared/oper?
  (lambda (exp)
    (or (eq? exp '@))))

(define boom/sugared/oper/eval
  (lambda (exp)
    (cond ((eq? (boom/oper exp) '@)
           (list (list (boom/left exp) '+ (boom/right exp)) '/ 2))
          (error "Invalid sugared app"))))

(define boom/sugared/app?
  (lambda (exp)
    (and (not (boom/app? exp))
         (and (eq? (length exp) 3)
             (boom/exp? (boom/left exp))
             (boom/sugared/oper? (boom/oper exp))
             (boom/exp? (boom/right exp))))))

(define boom/preprocess
  (lambda (exp)
    (cond ((eq? exp 'pi) 3.14)
          ((eq? exp 'e) 2.718)
          ((boom/number? exp) exp)
          ((boom/unary? exp) (cons
                              (boom/unary->oper exp)
                              (boom/preprocess (boom/unary->exp exp))))
          ((or (boom/app? exp)
               (boom/sugared/app? exp))
           (let ((desugar (if (boom/sugared/app? exp)
                              (boom/sugared/oper/eval exp)
                              exp)))
                 (list (boom/preprocess (boom/left desugar))
                       (boom/oper desugar)
                       (boom/preprocess (boom/right desugar)))))
          (error "Invalid syntax"))))

(display "Problem 2 pt 2 tests\n")
(eq? (boom/preprocess 'pi) 3.14)

(equal? (boom/preprocess '(((3.14 - 2) / e) % (15 / (pi % 2))))
        '(((3.14 - 2) / 2.718) % (15 / (3.14 % 2))))

(equal? (boom/preprocess '(((3.14 - 2) / e) @ (15 / (pi % 2))))
        '((((3.14 - 2) / 2.718) + (15 / (3.14 % 2))) / 2))

(equal? (boom/preprocess '(3 @ e))
        '((3 + 2.718) / 2))

;; Problem 3
(display "Problem 3 tests\n")
(zero? (- (boom/eval (boom/preprocess '(pi + e))) (+ 3.14 2.718)))

;; Problem 4
(display "Problem 4 tests\n")
(eq? (boom/with/eval '(with x = 2 do (15 + x))) 17)
