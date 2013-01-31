;; Head
(define head
  (lambda (s)
    (string-ref s 0)))

(define (heads strings)
  (map head strings))

(define (acronym strings)
  (apply string (heads strings)))

;; Tail
(define tail
  (lambda (s)
    (string-ref s (- (string-length s) 1))))

;; Identity
(define identity
  (lambda (x)
    x))

;; Sequence
(define sequence
  (lambda (start finish)
    (if (> start finish)
        '()
        (cons start (sequence (+ start 1) finish)))
    ))

;; CharAt
(define char-at
  (lambda (str)
    (lambda (pos)
      (string-ref str pos))))

;; Init-list
(define init-list
  (lambda (str)
    (map (char-at str) (sequence 1 (- (string-length str) 1)))))
  
;; Init
(define init
  (lambda (s)
    (apply string (init-list s))))