;; language
;<exp> ::= <varref>
;       | (lambda (<var>*) <exp>)
;       | (<exp>*)
;       | (if <exp> <exp> <exp>)


;; Write

;; if and app are just recursive calls
;; lambda creates new bindings

;(
; ((a b) 2) 
; ((c) 1)
;)


;(lambda (f)
;  (lambda (g x)
;    (f (g x))))

(define lexical-address-helper
  (lambda (exp bindings)
    (cond ((if? exp)
           ()) ;; merge lexical-address-helper here
          ((app? exp)
           ()) ;; merge lexical-address-helper here
          ((lambda? exp) 
           ()) ;; remmber variable declarations here
          ((varref? exp) 
           ()) ;; pass bindings over to another helper
          )))

;(define lexical-helper
;  (lambda (exp level pos)
;    (cond ((if? exp)
;           (list 'if 
;                 (lexical-helper (if->test exp) (+ level 1) pos)
;                 (lexical-helper (if->then exp) (+ level 1) pos)
;                 (lexical-helper (if->else exp) (+ level 1) pos)))
;          ((app? exp)
;           (append (map (lambda (lst) 
;                          lexical-helper lst (+ level 1) pos) exp)))
;          ((varref? exp)
;           (

;(define lexical-address-if
;  (lambda ()))

;(define lexical-address-lambda
;  (lambda (exp)
;    ()))
;
;(define-lexical-address-exp
;  (lambda (exp)))


;(define lexical-address
;  (lambda (exp)
;    (lexical-address-helper (free-vars exp) 0 exp)))
;
;(define lexical-address-helper
;  (lambda (free-vars level exp)
;    (if (lambda? (map (lexical-address-helper free-vars (+ level 1)) exp))
;        (


;(define lexical-address
;  (lambda (exp)
;    (if (
;    
;    
;    
;    (lexical-address-helper exp 0)))
;
;(define lexical-address-helper
;  (lambda (exp level)
;    (cond ((varref? exp)
;           ((list exp (+ level 1))))
;          ((lambda? exp)
;           (..))
;          ((if? exp)
;           (..))
;          (else (..))
;          )))