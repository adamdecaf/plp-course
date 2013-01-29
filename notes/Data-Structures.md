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

**Draw a picture**

    (cons (list 3 4)
          (cons (list 3 4))
                (list 4 5))

    A = (list 3 4)

    ---------     ----------
    | 3 |   |---->| 4  | \ |
    ---------     ----------

    B = (list 3 4)

    ---------     ----------
    | 3 |   |---->| 4  | \ |
    ---------     ----------

    C = (list 4 5)

    ---------     ----------
    | 3 |   |---->| 4  | \ |
    ---------     ----------

    (cons ...)
    ---------     ---------     ---------
    | A |   |---->| B |   |---->| C | \ |
    ---------     ---------     ---------

### Vectors
