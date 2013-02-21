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

## Combinators

* An expression with no free variables.
