;; Finite Functions extended
; (empty-ff)
; (extend-ff sym val ff)
; (extend-ff* sym-list val-list ff)
; (apply-ff ff sym)

(define empty-ff
  (lambda ()
    (lambda (sym)
      (error "empty ff"))))

(define extend-ff
  (lambda (sym val ff)
    (lambda (symbol)
      (if (eq? symbol sym)
          val
          (ff symbol)))))

(define vcontains
  (lambda (vec v)
    (vector-member vec v)))

(define vtail
  (lambda (vec)
    (vector-drop vec 1)))

(define vzero?
  (lambda (vec)
    (zero? (vector-length vec))))

(define extends-ff*
  (lambda (sym-lst val-lst ff)
    (lambda (sym)
      (if (or (vzero? sym-lst) 
              (vzero? val-lst))
          empty-ff
          (extend-ff (vtail sym-lst) 
                     (vtail val-lst) 
                     ff)))))
