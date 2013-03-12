## Our First Language

* Our first langugae will be comprised of this simple grammar.

```scheme
// Basic grammer
<exp> ::= <varref>
      | (lambda (<var>) <exp>)
      | (<exp> <exp)
```

Find in the following

all-decls
```scheme
((lambda (y)
   (square y))
 (sqrt 2))
```

```scheme
(define all-varrefs
  (lambda (exp)
    (cond (varref? (list exp))
          (lambda? (all-varrefs (lambda->body exp)))
          (else ;; app
                (append
                  (all-varrefs (app->procedure exp))
                  (all-varrefs (app->body exp)))))))
```

all-varrefs
```scheme
(square y
  sqrt x)
```
