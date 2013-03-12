;; Helpers
(define --
  (lambda (k)
    (- k 1)))

(define ++
  (lambda (k)
    (+ k 1)))

;; superpower n
;; 3 -> 3^3^3
(define superpower
  (lambda (n)
    (superpower-loop n n)))

(define (superpower-loop n count)
  (if (= count 1)
      n
      (expt n (superpower-loop n (- count 1)))))
