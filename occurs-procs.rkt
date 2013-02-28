;;  ------------------------------------------------------------------------
;; |                                                                        |
;; |   FILE           :   occurs-procs.ss                                   |
;; |   AUTHOR         :   Eugene Wallingford                                |
;; |   CREATION DATE  :   February 19, 2002                                 |
;; |                                                                        |
;; |   DESCRIPTION    :   These procedures compute one static feature       |
;; |                      of programs written in Session 11's little        |
;; |                      language:  Does a variable occur bound in a       |
;; |                      program?  Free?                                   |
;; |                                                                        |
;;  ------------------------------------------------------------------------
;; |                                                                        |
;; |   MODIFIED BY    :                                                     |
;; |   DATE           :                                                     |
;; |   DESCRIPTION    :                                                     |
;; |                                                                        |
;;  ------------------------------------------------------------------------

;;   This code works with the following grammar:
;;
;;        <exp>      ::= <varref>
;;                     | ( lambda ( <var> ) <exp> )
;;                     | ( <exp> <exp> )

(load "syntax-procs.ss")

(define occurs-bound?
  (lambda (s exp)
    (cond ((varref? exp) #f)
          ((app? exp) (or (occurs-bound? s (app->procedure exp))
                          (occurs-bound? s (app->argument  exp))))
          (else       (or (occurs-bound? s (lambda->body exp))
                          (and (eq? s (lambda->parameter exp))
                               (occurs-free? s (lambda->body exp))))))))

(define occurs-free?
  (lambda (s exp)
    (cond ((varref? exp) (eq? s exp))
          ((app? exp)    (or (occurs-free? s (app->procedure exp))
                             (occurs-free? s (app->argument  exp))))
          (else          (and (not (eq? s (lambda->parameter exp)))
                              (occurs-free? s (lambda->body exp)))))))