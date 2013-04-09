## Finite functions

Functions with a finite domain and codomain, and are bijective.

```scheme
;; classic square function
(define square
  (lambda (n)
    (* n n)))
```

So, example dmain/codomain sets could be..

```scheme
 {((1 1) (2 4) (3 8))}
 {((foo 2) (bar 5) (baz 18))}
 ...
```

*Verification*

* We can try to detect these by a trivial methods of comparing the inputs and ensuring the outputs will be in the codomain.
* This can lead to boilerplate that we may want to reduce if possible.
* Can we generate functions that will do this for us? Yep!

__Program Generation for Verification__
