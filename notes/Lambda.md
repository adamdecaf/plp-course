# Lambda

Lambda is a way we create procedure values

## Example

    > (lambda (x) (* x x))
    # procedure

    > ((lambda (x) (* x x)) 2)
    > 4

    > ((lambda (x)
         (+ x 10))
       1512)
    1522

    > (define square
        (lambda (x)
          (* x x)))

    > (define sum-of-squares
        (lambda (x y)
          (+ (square x) (square y))))

## Details

* Lambdas (and more generally procedures) are _first-class citizens_.
* A (lambda (x) (...)) does not evaluate its arguments, because it's a special form.
* Scheme supports overloading!

# First Class Citizens

* Apply can take an operation and apply it to the second argument it gets (similar to scalaz's apply)

    > (apply + '(1 2 3 4 5))
    15

* Sequence

    (define sequence
      (lambda (start finish)
        (if (> start finish)
          '()
           (cons start (sequence (+ start 1) finish)))
        ))

    > (sequence 1 10)
    (1 2 3 4 5 6 7 8 9 10)

    > (apply + (sequence 1 1000))
    500500

* Map

    > (map square (list 1 2 3 4))
    (1 4 9 16)

## UPC Codes

    3 + 2 + 18 + 4 + 3 + 0 = 30

    1   2   6   4   1   0
    _   _   _   _   _   _
    d1  d2  d3  d4  d5  d6

                  d(i)   if i is odd
    f(di...dj) =  3d(i)  if i is even

    \sum{f over all di's}

    ; Divisible by 10 so it's valid
