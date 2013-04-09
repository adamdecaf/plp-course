;; records

(define filter
  (lambda (lst f)
    (filter-helper lst f '())))

(define filter-helper
  (lambda (lst f acc)
    (if (null? lst)
        acc
        (if (f (car lst))
            (filter-helper (cdr lst) f (append acc (list (car lst))))
            (filter-helper (cdr lst) f acc)))))

;(filter (list 1 2 3 4) even?)

(define record3
  (lambda (s1 s2 s3)
    (list (list s1 0) (list s2 0) (list s3 0))))

(define address (record3 'city 'state 'zip))

(define record3-put
  (lambda (rec sym val)
    (list (list sym val)
          (filter rec (lambda (pair)
                        (not (eq? (car pair) sym)))))))

(define address2 (record3-put address 'city "Cedar Falls"))
address2

(define record3-get
  (lambda (rec sym)
    (let ((result (filter rec (lambda (pair)
                                (eq? (car pair) sym)))))
      (if (null? result)
          '()
          (cadar result)))))

(record3-get address2 'city)


;; map
(define lmap
  (lambda (lst f)
    (lmap-helper lst f '())))

(define lmap-helper
  (lambda (lst f acc)
    (if (null? lst)
        acc
        (lmap-helper (cdr lst) f (append acc (list (f (car lst))))))))

;(lmap (list 1 2 3 4) (lambda (x) (* x 2)))

;; n-airity records
(define record
  (lambda syms
    (lmap syms (lambda (sym) (list sym 0)))))

(record 'address 'city 'state 'zip)

(define record-put
  (lambda (rec sym val)
    (list (list sym val)
          (filter rec (lambda (pair)
                        (not (eq? (car pair) sym)))))))

(define record-get
  (lambda (rec sym)
    (let ((result (filter rec (lambda (pair)
                                (eq? (car pair) sym)))))
      (if (null? result)
          '()
          (cadar result)))))

(define address (record 'address 'city 'state 'zip))
(define address2 (record-put address 'city "Cedar Falls"))
address2
(record-get address2 'city)
2