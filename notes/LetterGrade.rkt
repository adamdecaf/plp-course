(define student 0.85)

(define (compute-grade score) (
        if (> score 0.89) "A" (
            if (> score 0.79) "B" (
               if (> score 0.69) "C" (
                  if (> score 0.59) "D" "F")))))

(define x (cons 1 2))
(define y (cons x x))
(define z (cons y 4))
(define w (cons z (cons y x)))