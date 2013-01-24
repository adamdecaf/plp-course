
; Quadratic formula

; (-b +/- sqrt(b2 - 4ac)) / 2a

;; (/
;;  (+ -b
;;     (sqrt (- (* b b) (* 4 (* a c))) (* 2 a))

; (/ (+ -b (sqrt((- (* b b) (* 4 (* a c)))))) (* 2 a))

(define (quadA a b c)
  (begin (/ (+ (- b) (sqrt(- (* b b) (* 4 a c)))) (* 2 a))))

(define (quadS a b c)
  (begin (/ (- (- b) (sqrt(- (* b b) (* 4 a c)))) (* 2 a))))

;;
;; (define x (cons 'z (cons (cons (cons 'b 'c) 'd) (cons 'a (cons 'e 'f)))))


;; > (define x /your answer/)
;; > (car (cdr x))
;; a
;; > (cdr (car x))
;; ((b c) d)
;; > (cdr (cdr x))
;; (e f)

;; (define x (cons 'z (cons 'a 'z)))
;; Works

;; (define x (cons (cons 'z (cons (cons 'b 'c) 'd)) (cons 'a 'z)))
;; Works

(define x (cons (cons 'z (cons (cons 'b 'c) 'd)) (cons 'a (cons 'e 'f))))



; (plus-or-minus (- b) (sqrt (- (* b b) (* 4 a c))))

(define (quadQ a b c)
  (begin (/ (+ (- b) (sqrt(- (* b b) (* 4 a c)))) (* 2 a))))

;; (define (quadQQ a b c)
;;   (begin (/
;;           (+ (* -1 b)
;;              (sqrt(- (* b b)
;;                      (* 4 (* a c))))))
;;           (* 2 a)
;;          ))
