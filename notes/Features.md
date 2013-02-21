## Static Features

* Can be determined by reading the code.

## Dynamic Features

* Can be determined by _running_ the code.

## Free & Bound Variables

* _Free_: "if" not bound
* _Bound_: Associaed with a formal paramater of a procedure.

```scheme
( (lambda (x) x) y) // y is free, x is bound

(lambda (y)
  (lambda (x) x) y) // both are bound
```

```scheme
;; No variable is really free

> (define x 1)
> (+ x 1) ;; + is really just bound when scheme starts
5
```

## Brain Teaser

```scheme
;; Is x free?
> (if (zero? 0) 1 x) ;; special forms!
1

;; Is x free?
> (lambda (y) x) ;; Deferred execution
#<procedure:...>

> ((lambda (y) x) _) ;; whoops

;; How about this?
> (lambda (y) (lambda (x) x)) ;; hmm?
#<procedure:...>

;; This?
> ((lambda (x)
     (lambda (y) y))
   x)

;; This is a free variable
> ((lambda (x)
    (lambda (z) z))
   (lambda (x) y)) ;; Never declares y, but can't change the output..
```

## Combinators

* An expression with no free variables.
