;; infinite list
(define infinite-list cons)

(define first car)
(define rest 
  (lambda (inf-list)
    (let ((next-value ((cdr inf-list) (car inf-list))))
      (cons next-value (cdr inf-list)))))

(define evens (infinite-list 0 (lambda (n) (+ n 2))))
(first evens)
(first (rest (rest (rest (rest (rest (rest (rest evens))))))))

;; get many
(define many
  (lambda (count)
    (many-helper count evens)))

(define many-helper
  (lambda (count lst)
    (if (zero? count)
        (first lst)
        (many-helper (- count 1) (rest lst)))))

(many 1000)

;; take on infinite list
(define take
  (lambda (n inf-lst)
    (take-helper n inf-lst '())))

(define take-helper
  (lambda (n inf-list acc)
    (if (zero? n)
        acc
        (take-helper (- n 1) 
                     (rest inf-list) 
                     (append acc (list (car inf-list)))))))

(take 10 evens)


;; drop on an infinite list
(define drop
  (lambda (n inf-list)
    (drop-helper n inf-list)))

(define drop-helper
  (lambda (n inf-list)
    (if (zero? n)
        inf-list
        (drop-helper (- n 1) (rest inf-list)))))

(drop 10 evens)
