# Abstractions

There are many forms of syntactic abstractions.

* if/cond
* procedures of airity > 1
* local variables.
  * make them paramaters on some procedure and recursively call it.


```
f(x) = x3 + y2 + 2x2 + y + x + xy - xy2 - y2 + 1
     = x(1+xy)2 + y(1-y) + (1 + xy)(1 - y)
     = xa2 + yb + ab where a = 1+xy and b = 1-y
```

and in scheme

```scheme
(define f
  (lambda (x y)
    (let ((a (+ 1 (* x y)))) ;; a and b are uninterpreted names
      (b (- 1 y)))
    (+ (* x (square a))
       (* y b)
       (* a b))))
```

## Let Expressions

```
<let-exp> ::= (let <bindings> <exp>)

<bindings> ::= ()
             | (<binding> <expression>)

<binding> ::= (<name> <exp>)
```

## What's the value?

```
> (+ (let ((x 2))
      (+ x (* x 10))) ;; x is bound
     x) ;; x is free

undefined
```

* All bindings come from formal paramaters. The region of a local variable is only in the body. (as expected)
* We can redefine let as a lambda that parses the bindings and passes them to the body to be evaluated.

```
(let ((x1 v1)
      (x2 v2)
      (x3 v3))
    exp)

equals

((lambda (x1 x2 x3)
  exp)
 v1 v2 v3)
```
