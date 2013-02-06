Welcome to DrRacket, version 5.3 [3m].
Language: R5RS; memory limit: 128 MB.
> (softmax 3 4)
4.313261687518223
> (softmax 10 6)
10.01814992791781
> (softmax 25 64)
64.0
> (sum-of-apps square 3 4)
25
> (sum-of-apps cube 3 4)
91
> (sum-of-apps sqrt 25 64)
13
>  ((candy-temperature-of 302) 5280)
291.44
>  (define temp-for-fudge
         (candy-temperature-of 240))
> (temp-for-fudge 959)
238.082
> ((in-range-of? 0.1) 4.95 5.0)
#t
> ((in-range-of? 0.1) 5.0 4.95)
#t
> (define within-0.01?
          (in-range-of? 0.01))
> (within-0.01? 4.95 5.0)
#f
> (within-0.01? 5.0 4.99)
#t
> (softmax-var 3 4 10 6)
10.021518480809299
> (softmax-var 25 64 100)
100.0
> (softmax-var 42)
42.0
> (apply softmax-var (sequence 1 709))
709.4586751453869
> 