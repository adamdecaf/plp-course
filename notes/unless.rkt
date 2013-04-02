;#lang racket

;; unless

(define unless
  (lambda (test body)
    (if (not test)
        body)))

(define go
  (lambda (x)
    (unless (negative? x) (sqrt x))))

(go 100)
(go 10)
(go -1)


;; syntax
(define unless->test cadr)
(define unless->body caddr)

(define unless->if
  (lambda (exp)
    (list 'if (list 'not (unless->test exp))
          (unless->body exp)
          #f)))

(unless->if '(unless (negative? x) (sqrt x)))

;; ifnot
(define ifnot->test cadr)
(define ifnot->body caddr)

(define ifnot->if
  (lambda (exp)
    (list 'if (list 'not (ifnot->test exp))
          (ifnot->body exp)
          #f)))

(ifnot->if '(unless (negative? x) (sqrt x)))


;; macro
(require compatibility/defmacro)

(defmacro unless (test action)
  (list 'if (list 'not test) action #f))
