(define vector-number?
  (lambda (n vec)
    (vector-number-at? 0 n vec)))

(define vector-number-at?
  (lambda (i n vec)
    (if (>= i (vector-length vec))
        #f
        (or (= n (vector-ref vec i))
            (vector-number-at? (+ i 1) n vec)))))

;; Replace all 'old with 'new in some s-list
(define subst
  (lambda (new old slist)
    (if (null? slist)
      '()
      (cons
        (if (symbol? (car slist))
          (if (eq? old (car slist)) new (car slist))
          (subst new old (car slist)))
        (subst new old (cdr slist))))))