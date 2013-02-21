# S-List

An S-List is a list that has symbols.

    s-list            ::= () | (symbol-expression . s-list)
    symbol-expression ::= symbol | s-list

## Mapping

```scheme
(define map-slist
  (lambda (f lst)
    (if (null? lst)
        '()
        (cons (if (list? (car lst))
                  (map-slist f (car lst))
                  (f (car lst)))
              (map-slist f (cdr lst))))))

(define sym->string
  (lambda (sym)
    sym))

(define mylst '((a b) (((b g r) (f r)))))

;; Run it

> (map-slist sym->string mylst)
((a b) (((b g r) (f r))))

```

## Fringe (flatten)

```scheme
;; fringe
(define fringe
  (lambda (lst)
    (if (null? lst)
        '()
        (append (fringe-helper (car lst))
                (fringe (cdr lst))))))

(define fringe-helper
  (lambda (symexp)
    (if (symbol? symexp)
        (list symexp)
        (fringe symexp))))
```

## Factorial

```scheme
(define factorial-aps
  (lambda (n)
    (smart-factorial n 1)))

(define smart-factorial
  (lambda (n answer)
    (if (zero? n)
        answer
        (smart-factorial (- n 1)
                         (* n answer)))))
```scheme


## (count-occurences s slist)

```scheme
(define count-occurences-accum
  (lambda (s slist count)
    (if (null? slist)
        count
        (count-occurences-symexp s (car slist)
                                (count-occurences-accum s (cdr slist) count)))))

(define count-occurences-symexp
  (lambda (s symexp count)
    (if (symbol? symexp)
        (if (eq? s symexp) (+ count 1) count)
        (count-occurences-accum s symexp count))))

;; Interface Method
(define count-occurences
  (lambda (s symexp)
    (count-occurences-accum s symexp 0)))
```

## Tail Recursion

Egads! You can (basically) convert a recursive method into a loop so it doesn't blow stacks?
