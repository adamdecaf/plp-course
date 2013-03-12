# Lexical Addresses

Just some sample lisp code.

```scheme
;; Sample
(lambda (x y)    ;; x has position 0, y has position 1
  ((lambda (a)   ;; a has position 0
     (x (a y)))  ;; a has depth of 0, x and y have depth 1
   x))           ;; (x 0 0) -- same block
```

The idea of a *Lexical Address* consists of two things:

* depth of reference to decleration (to the variable I refer to declared)
* (absolute) position in the block where the reference occurs.

*Addresses*

* `(a d p)`
* `(a 0 0)`
* `(x 1 0)`
* `(y 1 1)`


_Examples_

Find the lexical addresses

```scheme
(lambda (x)
  (lambda (y)
    ((lambda (x)
       (x y))
     x)))
```

*Addresses*

* `(a d p)`
* `(x 0 0)`
* `(y 1 0)`
* `(x 1 0)`

```scheme
(lambda (f g)
  (lambda (x)
    (f (g x))))
```

*Addresses*

* `(a d p)`
* `(f 1 0)`
* `(g 1 1)`
* `(x 0 0)`

```scheme
(lambda (x) (x 3))
(lambda (x) (k x x))
```

*Addresses*

* `(a d p)`
* `(x 0 0)`
* `(x 0 0)`
* `(k 1 0)` ;; free variable w/ unknown position
