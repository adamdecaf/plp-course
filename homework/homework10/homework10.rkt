;;
;; FILE:     homework10.rkt
;; AUTHOR:   Adam Shannon
;; DATE:     04/16/2013
;; COMMENT:  Homework code
;;
;; MODIFIED: 04/16/2013
;; CHANGE:   First commit of code.
;;
(require racket/vector)
(require racket/list)
(load "boom-language.rkt")

;; Problem #1
;; (int->bignum n) -- return a list representation of n
(define int->bignum
  (lambda (n)
    (int->bignum-helper n '())))

(define int->bignum-helper
  (lambda (n acc)
    (if (> 0 n)
        acc
        (if (> 10 n)
            (append acc (list n))
            (int->bignum-helper (quotient n 10)
                                (append acc (list (remainder n 10))))))))

(display "int->bignum tests\n")
(equal? (int->bignum 0) '(0))
(equal? (int->bignum 16) '(6 1))
(equal? (int->bignum 4256) '(6 5 2 4))
(equal? (int->bignum 262144) '(4 4 1 2 6 2))

;; Problem #2
;; (bignum->int n)
(define bignum->int
  (lambda (bign)
    (foldl (lambda (n acc)
             (+ (* acc 10) n)) 0 (reverse bign))))

(display "bignum->int tests\n")
(zero? (- (bignum->int '(0)) 0))
(zero? (- (bignum->int '(6 1)) 16))
(zero? (- (bignum->int '(6 5 2 4)) 4256))
(zero? (- (bignum->int '(4 4 1 2 6 2)) 262144))

;; Problem #3
;; (big+ m n) -- + on two bignums

;; little helper, zipWith
(define zipWith
  (lambda (l1 l2 f)
    (let ((len (min (length l1) (length l2))))
      (zipWith-helper (take l1 len)
                      (take l2 len)
                      f
                      '()))))

(define zipWith-helper
  (lambda (l1 l2 f acc)
    (if (or (null? l1) (null? l2))
        acc
        (zipWith-helper (cdr l1)
                        (cdr l2)
                        f
                        (append acc (list (f (car l1) (car l2))))))))

(display "zipWith tests\n")
(equal? (zipWith '(1 2 3) '(4 5 6) +) '(5 7 9))
(equal? (zipWith '(1) '(3 4) +) '(4))
(equal? (zipWith '(3 4) '(1) +) '(4))

;; solution
(define big+
  (lambda (m n)
    (let ((mlen (length m))
          (nlen (length n))
          (diff (abs (- (length m) (length n)))))
      (cond ((> mlen nlen)
             (big+helper (drop-right m diff)
                         n
                         (take-right m diff)))
            ((< mlen nlen)
             (big+helper m
                         (drop-right m diff)
                         (take-right n diff))
            ((= mlen nlen)
             (big+helper m n '())))))))

(define big+helper
  (lambda (m n res)
    (append (zipWith m n (lambda (a b)
                           (+ a b))) res)))


(display "big+ tests\n")
(eq? (bignum->int (big+ (int->bignum 123) (int->bignum 45))) 168)


;; Problem #4
(display "boom/eval with unary operators tests\n")
(boom/eval '(- 3))
(boom/eval '(- (- 9)))
(boom/eval '(sqrt 9))
(boom/eval '((- 3) + (sqrt (4 * 16))))
(boom/eval '(((130 - 2) / 4) % (15 / (17 % (sqrt 36)))))

;; Problem #5
;(boom/preprocess sugared-exp)
(define boom/sugared/oper?
  (lambda (exp)
    (or (eq? exp '@))))

(display "boom/sugared/oper? tests\n")
(boom/sugared/oper? '@)
(not (boom/sugared/oper? '+))

(define boom/sugared/oper/eval
  (lambda (exp)
    (cond ((eq? (boom/oper exp) '@)
           (list (list (boom/left exp) '+ (boom/right exp)) '/ 2))
          (error "Invalid sugared app"))))

(display "boom/sugared/oper/eval tests\n")
(equal? (boom/sugared/oper/eval '(3 @ 9)) '((3 + 9) / 2))

(define boom/sugared/app?
  (lambda (exp)
    (and (not (boom/app? exp))
         (and (eq? (length exp) 3)
             (boom/exp? (boom/left exp))
             (boom/sugared/oper? (boom/oper exp))
             (boom/exp? (boom/right exp))))))

(display "boom/sugared/app? tests\n")
(boom/sugared/app? '(3 @ 2))
(not (boom/sugared/app? '(3 + 2)))

(define boom/preprocess
  (lambda (exp)
    (cond ((boom/number? exp) exp)
          ((boom/unary? exp) (cons
                              (boom/unary->oper exp)
                              (boom/preprocess (boom/unary->exp exp))))
          ((or (boom/app? exp)
               (boom/sugared/app? exp))
           (let ((desugar (if (boom/sugared/app? exp)
                              (boom/sugared/oper/eval exp)
                              exp)))
                 (list (boom/preprocess (boom/left desugar))
                       (boom/oper desugar)
                       (boom/preprocess (boom/right desugar)))))
          (error "Invalid syntax"))))

(display "boom/preprocess tests\n")
(equal? (boom/preprocess '(3 @ 9)) '((3 + 9) / 2))
