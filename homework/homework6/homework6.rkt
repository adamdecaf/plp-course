;;
;; FILE:     homework6.rkt
;; AUTHOR:   Adam Shannon
;; DATE:     02/26/2013
;; COMMENT:  Homework code
;;
;; MODIFIED: 02/26/2013
;; CHANGE:   First commit of code.
;;

;; Dr. Wallingford: Are you okay with this style of testing/interactions?
;; I've found it's easier to build all of the methods this way.

;; == Reference == 
;; <2-list> ::= (<item1> <item2>)

;; <binary-tree> ::= <number>
;;                    |  (<number> <binary-tree> <binary-tree>)

;; (zip lst1 lst2)
;; zip two lists together to make an list of 2-lists
(define zip
  (lambda (lst1 lst2)
    (zip-helper lst1 lst2 '())))

(define zip-helper
 (lambda (lst1 lst2 acc)
   (if (or (null? lst1)
           (null? lst2))
       acc
       (zip-helper (cdr lst1) (cdr lst2)
                   (append acc (list (list (car lst1) (car lst2))))))))

;; zip tests
(zip '(a b c) '(1 2 3))
(zip '(a b c) '(1 2))
(zip '(a b) '(1 2 3))

(equal? (zip '(a b c) '(1 2 3)) '((a 1) (b 2) (c 3)))
(equal? (zip '(a b c) '(1 2)) '((a 1) (b 2)))
(equal? (zip '(a b) '(1 2 3)) '((a 1) (b 2)))

;; (tails lst)
;; returns all the sublists of the list
(define tails
  (lambda (lst)
    (if (null? lst)
        '()
        (tails-helper lst (list lst)))))

(define tails-helper
  (lambda (lst acc)
    (if (null? lst)
        acc
        (tails-helper (cdr lst) (append acc (list (cdr lst)))))))

;; tails tests
(tails '(a b c d e f g))
(tails '((a b) (c d)))
(tails '())

(equal? (tails '(a b c d e f g))
        '((a b c d e f g) (b c d e f g) (c d e f g) (d e f g) (e f g) (f g) (g) ()))

(equal? (tails '((a b) (c d))) '(((a b) (c d)) ((c d)) ()))
(equal? (tails '()) '())

;; (swap var1 var2 s-list) 
;; swap every var1 with var 2
;; swap every var2 with var1
(define swap
  (lambda (var1 var2 lst)
    (if (null? lst)
        '()
        (if (list? (car lst))
            (cons (swap var1 var2 (car lst))
                  (swap var1 var2 (cdr lst)))
            (if (eq? var1 (car lst))
                (cons var2 (swap var1 var2 (cdr lst)))
                (if (eq? var2 (car lst))
                    (cons var1 (swap var1 var2 (cdr lst)))
                    (cons (car lst) (swap var1 var2 (cdr lst)))))))))
  
;; swap tests
(swap 'a 'b '((a b) (((b g r) (f r)) c (d e)) b))
(swap 'a 'b '((a a) (((a (a) (a a)) (a (aaaa))) a (a a)) a))

 (equal? (swap 'a 'b '((a b) (((b g r) (f r)) c (d e)) b)) 
    '((b a) (((a g r) (f r)) c (d e)) a))

 (equal? (swap 'a 'b '((a a) (((a (a) (a a)) (a (aaaa))) a (a a)) a))
    '((b b) (((b (b) (b b)) (b (aaaa))) b (b b)) b))


;; (uniq-c s-list) 
;; count the number of times a symbol occurs
(load "inc-count.rkt") ;; from session11

(define uniq-c
  (lambda (lst)
    (uniqc-helper lst '())))

(define uniqc-helper
  (lambda (lst acc)
    (if (null? lst)
        acc
        (if (list? (car lst))
            (uniqc-helper (cdr lst) (uniqc-helper (car lst) acc))
            ;(uniqc-helper (car lst) (uniqc-helper (cdr lst) acc)) ;; either way works
            (uniqc-helper (cdr lst) (inc-count (car lst) acc))))))

;; uniq-c tests
(uniq-c '((a b) (((b g r) (f r)) c (d e)) b))
(uniq-c '((a a) (((a (a) (a a)) (a (aaaa))) a (a a)) a))

(equal? (uniq-c '((a b) (((b g r) (f r)) c (d e)) b))
        '((a . 1) (b . 3) (g . 1) (r . 2) (f . 1) (c . 1) (d . 1) (e . 1)))

(equal? (uniq-c '((a a) (((a (a) (a a)) (a (aaaa))) a (a a)) a))
        '((a . 11) (aaaa . 1)))


;; == Reminder ==
;; <binary-tree> ::= <number>
;;                    |  (<number> <binary-tree> <binary-tree>)

(define first
  (lambda (lst)
    (list-ref lst 0)))

(define middle
  (lambda (lst)
    (list-ref lst 1)))

(define last
  (lambda (lst)
    (list-ref lst 2)))

;; (bst? bin-tree) 
;; returns true/false if the binary search tree is a tree or not.
(define bst?
  (lambda (lst)
    (if (null? lst)
        #t
        (and (number? (first lst))
             (or (number? (middle lst))
                 (bst? (middle lst)))
             (or (number? (last lst))
                 (bst? (last lst)))))))

;; bst? tests
(bst? '(8 (3 1 5) (15 12 20)))
(bst? '(8 (3 1 12) (15 5 20)))
(bst? '(8 (1 3 12) (15 12 20)))
(bst? '(8 (3 1 (5 4 6)) (15 (12 10 14) 20)))

;                 8
;            3         15   
;          1   5     12   20
;            4   6 10  14

;; helpers
(define true?
  (lambda (b)
    b))

(define false?
  (lambda (b)
    (not (true? b))))

(true? (bst? '(8 (3 1 5) (15 12 20))))
(false? (bst? '(8 (3 1 12) (15 5 20))))
(false? (bst? '(8 (1 3 12) (15 12 20))))
(true? (bst? '(8 (3 1 (5 4 6)) (15 (12 10 14) 20))))