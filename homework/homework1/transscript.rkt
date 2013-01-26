;; Homework 2
;; Author: Adam Shannon

1) What is the value of each of these expressions?

> (* 3 (- 12 5))
21
> (- 10 (- 8 (- 6 4)))
4
>  (/ 40 (* 5 20))
2/5
> (+ (* 0.01 20) (/ 4 -3))
-1.1333333333333333


2) Give Scheme expressions to compute the values of:


> (+ 5 (- (* 4 7) 13))
20
> (- (* 4 7) (+ 13 5))
10
> (- -2.2 (+ 6.1 (* 4 1/6)))
-8.966666666666667
> (+ 6.1 (* 4 (- 1/6 -2.2)))
15.566666666666666


3) Give an expression to compute the value of either of the roots of the equation 3x2 + 17x - 12 = 0

> (define (quadA a b c)
  (begin (/ (+ (- b) (sqrt(- (* b b) (* 4 a c)))) (* 2 a))))

(define (quadS a b c)
  (begin (/ (- (- b) (sqrt(- (* b b) (* 4 a c)))) (* 2 a))))>

> (quadA 3 17 -12)
0.6347753411141355

> (quadS 3 17 -12)
-6.301442007780802

>

4) Assume that the following definitions have been made, in the given order:

(define big-number 10500900)
     (define small-number 0.00000025)
     (define indiana 'hoosiers)
     (define number1 big-number)
     (define number2 'big-number)> > > >

> (define big-number 10500900)
     (define small-number 0.00000025)
     (define indiana 'hoosiers)
     (define number1 big-number)
     (define number2 'big-number)> > > >

> big-number
10500900 ; Variable Access

> small-number
2.5e-07 ; Variable Accees

> 'big-number
'big-number ; Symbol

> indiana
'hoosiers ; Variable

> 'indiana
'indiana ; Symbol

> number1
10500900 ; Variable Access

> number2
'big-number ; Variable of a symbol

> 'number1
'number1 ; Symbol

5) Show the sequence of cars and cdrs that return a, b, c, and d when applied to the expression ((a b) ((c) d)).

> (define e (cons (cons 1 2) (cons 3 4)))

> (car (car e))
1

> (car (cdr e))
3

> (cdr (car e))
2

> (cdr (car e))
2

> (cdr (cdr e))
4

6) Show the sequence of cars and cdrs that return x when applied to the following expressions:

;; (5 4 3 (x) 1)

;; (1 (2 (3) 4 5) (6 x 8))

;; (((1 ((x)) ((3 4) 5))))

7) Construct a single list x that satisfies the following interaction:

> (define x (cons (cons 'z (cons (cons 'b 'c) 'd)) (cons 'a (cons 'e 'f))))
> (car (cdr x))
'a

> (cdr (car x))
'((b . c) . d)

> (cdr (cdr x))
'(e . f)

8) Compute by hand the length of each of the lists in Exercise 6. Then confirm them in an Dr. Racket interaction. What is the length of a Scheme value that is not a list?
