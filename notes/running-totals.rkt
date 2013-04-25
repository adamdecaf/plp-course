;; running total
;; bad way, global variable..
(define sum 0)

(define ++
  (lambda items
    (map (lambda (elm) (set! sum (+ elm sum))) items)
    sum))

(display "Global Variable way.\n")
(++ 1 2)
(++ 3 4)

;; Better way, return a closure.
(define +++
  (lambda (init)
    (lambda items
      (map (lambda (e) (set! init (+ init e))) items)
      init)))

(display "Closure version\n")
(define counter++ (+++ 0))
(counter++ 1 2)
(counter++ 3 4)
