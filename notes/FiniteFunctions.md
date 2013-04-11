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

```scheme
;; simple, but naive
(define f
  (lambda (avg)
    (cond ((eq? avg 'foo) 7)
          ((eq? avg 'bar) 5)
          ((eq? avg 'baz) 15)
          (else (error "Error..")))))
```

Then, take this improvement

```scheme
;; Create an inductive finite function definition.
(define empty-ff
  (lambda ()
    (lambda (sym)
      (error "..."))))

(define extend-ff
  (lambda (sym val ff)
    (lambda (symbol)
      (if (eq? sym symbol)
        val
        (ff symbol)))))

(define apply-ff
  (lambda (ff sym)
    (ff sym)))
```
