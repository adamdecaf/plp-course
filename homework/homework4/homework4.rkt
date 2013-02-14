;;
;; FILE:     homework4.rkt
;; AUTHOR:   Adam Shannon
;; DATE:     02/13/2013
;; COMMENT:  Homework code
;;
;; MODIFIED: 02/13/2013
;; CHANGE:   First commit of code.
;;

;; (drop n lst)
(define drop
  (lambda (n lst)
    (if (zero? n)
        lst
        (drop (- n 1) (cdr lst)))))

;; (any? lst)
(define any?
  (lambda (lst)
    (if (null? lst)
        #f
        (if (not (car lst))
            (any? (cdr lst))
            #t)))) ;; Sorry about this...

;; (count sym lst)
(define count
  (lambda (sym lst)
    (count-helper sym lst 0)))

(define count-helper
  (lambda (sym lst count)
    (if (null? lst)
        count
        (if (eq? sym (car lst))
            (count-helper sym (cdr lst) (+ count 1))
            (count-helper sym (cdr lst) count)))))

;; (detect test? lst)
(define detect
  (lambda (test? lst)
    (if (test? (car lst))
        (car lst)
        (detect test? (cdr lst)))))

;; (positions-of s lst)
(define positions-of 
  (lambda (s lst)
    (positions-of-helper s lst 0 '())))

(define positions-of-helper
  (lambda (s lst pos ret)
    (if (null? lst)
        ret
        (if (eq? s (car lst))
            (positions-of-helper s (cdr lst) (+ pos 1) (cons pos ret))
            (positions-of-helper s (cdr lst) (+ pos 1) ret)))))