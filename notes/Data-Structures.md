# Scheme's Data Structures

* values
* operations
* "looks like" (data representation vs human readable)

## Aggregate Data Types

### Pair

* cons (allows us to create pairs)
* car/cdr

    (define x (cons 1 2))
    (define y (cons x x))
    (define z (cons y 4))
    (define w (cons z (cons y x)))

#### Lists
A list is a pair whose second part is another list. (With the final pointer being null)

* lists can be nested to any depth we want
* the _cdr_ of any list is another list.

### Vectors
