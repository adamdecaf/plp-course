# Scheme's Data Structures

* values
* operations
* "looks like" (data representation vs human readable)

## Aggregate Data Types

### Pair

* cons (allows us to create pairs)
* car/cdr


## Examples

    (define x (cons 1 2))
    (define y (cons x x))
    (define z (cons y 4))
    (define w (cons z (cons y x)))

## List

A list is a pair whose second part is another list. (With the final pointer being null)
