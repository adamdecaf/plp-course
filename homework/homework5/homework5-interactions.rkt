Welcome to DrRacket, version 5.3 [3m].
Language: R5RS; memory limit: 512 MB.
> (all-positive? '(1 -2 3 4))
#f
> (all-positive? '((1 (2 7 (10))) (-3 4)))
#f
> (all-positive? '((1 (2 7 (10))) (3 4)))
#t
> (reject even? '(1 -2 3 4))
(3 1)
> (reject positive? '(1 -2 3 4))
(-2)
> (reject (lambda (n) (< n 4))
                 '((1 (2 7 (10))) (3 4)))
(4 10 7)
> (reject negative? '((1 (2 7 (10))) (3 4)))
(4 3 10 7 2 1)
> (reject positive? '((1 (2 7 (10))) (3 4)))
()
> (inject 0 + '(25 50 -30 45 -10 -15))
65
> (define balance 955.52)
>  (define transactions '(27.52 27.52 -50.00 37.52 -50.00))
> (define new-balance (inject balance + transactions))
> new-balance
948.0799999999999
> (inject 0 max                 ;; find largest num <= 6
               (reject (lambda (n) (> n 6))
                         '((1 (2 7 (-10))) (3 3))))
3
> (uniq '((a b) (((b g r) (f r)) c (d e)) b))
(a b ((b g r) (f r)) c (d e))
> (uniq '((a a) (((a (a) (a a)) (a (aaaa))) a (a a)) a))
(a a ((a (a) (a a)) (a (aaaa))) a (a a))
> (prefix->infix '(* (+ 4 5)
                          (+ 7 6)))
((4 + 5) * (7 + 6))
> (prefix->infix '(* (* (+ 3 5)
                             (- 3 (/ 4 3)))
                          (- 25 4)))
(((3 + 5) * (3 - (4 / 3))) * (25 - 4))
> (prefix->infix '(* (* (+ 3 5) (- 3 (/ 4 3))) (- (* (+ 4 5) (+ 7 6)) 4)))
(((3 + 5) * (3 - (4 / 3))) * (((4 + 5) * (7 + 6)) - 4))
> 