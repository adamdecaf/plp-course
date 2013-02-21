;; Write Drop
(define drop
  (lambda (n lst)
    (if (zero? n)
        lst
        (drop (- n 1) (cdr lst)))))

;; Write Take
(define take
  (lambda (n lst)
    (take-helper n lst '())))

(define take-helper
  (lambda (n lst acc)
    (if (zero? n)
        acc
        (take-helper (- n 1) (cdr lst) (cons (car lst) acc)))))

;;
