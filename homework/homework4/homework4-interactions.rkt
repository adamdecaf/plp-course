Welcome to DrRacket, version 5.3 [3m].
Language: R5RS; memory limit: 512 MB.
> (drop 0 '(1 2 3 4 5))
(1 2 3 4 5)
> (drop 0 '(a b c d e))
(a b c d e)
> (drop 5 '(1 2 3 4 5))
()
> (any? '(#t))
#t
> (any? '(#f))
#f
> (any? '(#f #f #f #t #f #f))
#t
> (any? '(#f #f #f #f))
#f
> (any? '())
#f
> (count 'a '(a b a c d a e f g a h i j k))
4
>  (count 'a '(b c d e f g h i j k))
0
> (detect positive? '(1 -1 2 -2 3 -3 4 -4 -5))
1
> (detect boolean? (list 1 'a 't #t "false" #f '(a . b)))
#t
> (detect pair? (list 'a 't #t '(1 2 3) "false" #f '(a . b)))
(1 2 3)
> (detect number? (list 'a 't #t '(1 2 3) "false" #f '(a . b)))
. . mcar: contract violation
  expected: mpair?
  given: ()
>  (detect (lambda (x)
                 (not (number? x)))
               (list 1 'a 't #t '(1 2 3) "false" #f '(a . b)))
a
> (detect (lambda (n)
                 (> n 1008))
               (sequence 1000 1010))
. . sequence: undefined;
 cannot reference undefined identifier
> (detect (lambda (n)
                 (> n 1)) (list 1 3 4 5))
3
> (positions-of 'a '(a b a c d a e f g a h i j k))
(9 5 2 0)
> (positions-of 'a '(b c d e f g h i j k))
()
> (= (count 'a '(a b a c d a e))
          (length (positions-of 'a '(a b a c d a e))))
#t
> 