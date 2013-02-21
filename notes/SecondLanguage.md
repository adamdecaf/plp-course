# Our Second Language

* Our language will contains:

```schemescheme
<exp> ::= <varref>                 ;; varref
      | (lambda (<var>) (<exp>))   ;; lambda
      | (<exp <exp>)               ;; app
```

_Examples_:

```scheme
x                               - yes
(lambda (x) y)                  - yes
()                              - no
(lambda (x) (lambda (y) (x y))) - yes
((lambda (x) x) (lambda (y) y)) - yes
```

_Notes_:

* The only way to be bound is to occur in a lambda's <var> and then its <exp>.

_Free Laws_:

* v occurs free in exp iff
  * exp is a varref and identical to v
  * exp is (lambda (var) body) and v occurs free in body and v != var
  * exp is (exp1 exp2) and v occurs free in either exp1 or exp2

_Bound Laws_:

* v occurs bound in exp iff
  * exp is (lambda (exp) body) and either
    * v is free in body and v = var
    * v is bound in body
  * exp is (exp1 exp2) and v occurs bound in either exp1 or exp2


```scheme
(define occurs-bound
  (lambda (v exp)
    (cond ((varref? exp) #f)
          ((app? exp) (or
                         (occurs-bound (app->procedure exp))
                         (occurs-bound (app->argument exp))))
          (else ;lambda
            (or (and (occurs-free? v (lambda->body exp))
                     (ep? v (lambda->procedur exp)))
                (occurs-bound? v (lambda->body exp)))))))
```

_Given Syntax Procedures_ (Type Procedures):

* exp?
* varref?
* lambda?
* app?
