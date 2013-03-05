# Usage of Let (local names)

Sample code..

```
(define swap
  (lambda (2-list)
    (list (cadr 2-list) (car 2-list))))

(define inverse
  (lambda (list-of-2-lists)
    (map swap list-of-2-lists)))
```

Or, with lets.

```
(define inverse
  (lambda (list-of-2-lists)
    (let ((swap (lambda (2-list) (list (cadr 2-list) (car 2-list)))))
        (map swap list-of-2-lists))))
```
