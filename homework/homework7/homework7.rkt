;;
;; FILE:     homework6.rkt
;; AUTHOR:   Adam Shannon
;; DATE:     02/26/2013
;; COMMENT:  Homework code
;;
;; MODIFIED: 02/26/2013
;; CHANGE:   First commit of code.
;;

(load "syntax-procs.rkt")

;; LL
;; <exp> ::= <varref>
;;       | (lambda (<var>) <exp>)
;;       | (<exp> <exp>)

;; -----------------------------------------------------------
;; Problem 1
;; -----------------------------------------------------------

;; Extend LL to
;          <exp> ::= <varref>
;                  | <boolean>
;                  | (lambda (<var>) <exp>)
;                  | (<exp> <exp>)
;                  | (if <exp> <exp> <exp>)
;
;      <boolean> ::= t | f

(define if->sym
  (lambda (exp)
    (car exp)))

(define if->test
  (lambda (exp)
    (car (cdr exp))))

(define if->then
  (lambda (exp)
    (car (cdr (cdr exp)))))

(define if->else
  (lambda (exp)
    (car (cdr (cdr (cdr exp))))))

;; Tests
(define if-exp '(if? (= 12 2) 100 #f))

(eq? (if->sym if-exp) 'if?)
;(eq? (if->test if-exp) (= 12 2)) ; works
(eq? (if->then if-exp) 100)
(eq? (if->else if-exp) #f)

(define if?
  (lambda (exp)
    (and (list? exp)
         (= 4 (length exp))
         (eq? 'if? (if->sym exp))
         (exp? (if->test exp))
         (exp? (if->then exp))
         (exp? (if->else exp))
         )))

(define test-if-exp '(if? (lambda (x) x) (lambda (x) x) (lambda (x) x)))
(if? test-if-exp)  
          
;; -----------------------------------------------------------
;; Problem 2
;; -----------------------------------------------------------
;
;          <exp> ::= <varref>
;                  | <boolean>
;                  | (lambda (<var>) <exp>)
;                  | (<exp> <exp>)
;                  | (if <exp> <exp> <exp>)
;                  | (let <binding> <exp>)
;                  | (and <exp> <exp>)
;                  | (or <exp> <exp>)
;
;      <boolean> ::= t | f
;
;     <binding>  ::= (<var> <exp>)

(define binding->name
  (lambda (exp)
    (car exp)))

(define binding->value
  (lambda (exp)
    (car (cdr exp))))

;; binding tests
(define test-binding '(a (lambda (x) x)))
(eq? (binding->name test-binding) 'a)
;(eq? (binding->value test-binding) (lambda (x) x)) ; works

(define binding?
  (lambda (exp)
    (and (list? exp)
         (= 2 (length exp))
         (symbol? (binding->name exp))
         (exp? (binding->value exp)))))

;; binding tests
(binding? test-binding)



;; let
;; (let <binding> <exp>)
;; <binding>  ::= (<var> <exp>)
(define let->local-name
  (lambda (exp)
    (binding->name (car (cdr exp)))))

(define let->local-value
  (lambda (exp)
    (binding->value (car (cdr exp)))))

(define let->body
  (lambda (exp)
    (car (cdr (cdr exp)))))

;; let accessor tests
(define test-let '(let (a (lambda (x) x)) (lambda (y) y)))
(eq? (let->local-name test-let) 'a)
;(let->local-value test-let) ;'(lambda (x) x)
;(let->body test-let) ;'(lambda (y) y)

(define let?
  (lambda (exp)
    (and (list? exp)
         (= 3 (length exp))
         (= 2 (length (car (cdr exp))))
         (eq? 'let (car exp))
         (symbol? (let->local-name exp))
         (exp? (let->local-value exp))
         (exp? (let->body exp)))))

(let? test-let)

;; -----------------------------------------------------------
;; Problem 3
;; -----------------------------------------------------------

;; Write
;; > (let->app '(let (a b) a))
;; ((lambda (a) a) b)

(define let->app
  (lambda (exp)
    (list (list 'lambda (list (let->local-name exp))
                (let->local-value exp))
          (let->body exp))))

(let->app '(let (a b) a))

;; -----------------------------------------------------------
;; Problem 4
;; -----------------------------------------------------------
;; write to desugar each exp

;; (and->if and-exp)
;; and ; (and <exp> <exp>)
;; > (and->if '(and a b))
;; (if a b f)

(define and->first
  (lambda (exp)
    (car (cdr exp))))

(define and->second
  (lambda (exp)
    (car (cdr (cdr exp)))))

;; tests
(define test-and '(and (f x) (f y)))
(and->first test-and)
(and->second test-and)

(define and->if
  (lambda (exp)
    (list 'if 
          (and->first exp)
          (and->second exp)
          'f)))

(and->if test-and)

;; (or->if or-exp)
;; or  ; (or <exp> <exp>)
;; > (or->if '(or (f x) (f b)))
;; (if (f x)
;;     t
;;     (f b))

(define or->first 
  (lambda (exp)
    (car (cdr exp))))
    
(define or->second
  (lambda (exp)
    (car (cdr (cdr exp)))))

;; tests
(define test-or '(or (f x) (f y)))
(or->first test-or)
(or->second test-or)

(define or->if
  (lambda (exp)
    (list 'if
          (or->first test-or)
          'f
          (or->second test-or))))

(or->if test-or)

;; -----------------------------------------------------------
;; Problem 5
;; -----------------------------------------------------------

;; write
;; (types-match? types values) -- return true if every member of values 
;; passes the types element at the same position.
;; types - list of type predicates
;; values - list of values

(define types-match?
  (lambda (types values)
    (if (null? values)
        #t
        (if (= 1 (length types))
            (and ((car types) (car values))
                 (types-match? types (cdr values)))
            (types-match? (cdr types) (cdr values))))))

(types-match? '() '())
(types-match? (list number?) (list 42))
(types-match? (list number? string?) (list 42 "adam"))
(types-match? (list number?) (list 42 24 0))

(eq? (types-match? '() '()) #t)
(eq? (types-match? (list number?) (list 42)) #t)
(eq? (types-match? (list number? string?) (list 42 "adam")) #t)
(eq? (types-match? (list number?) (list 42 24 0)) #t)