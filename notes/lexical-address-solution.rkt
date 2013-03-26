;; Lexical Address Solution

(define lexical-address
  (lambda (exp)
    (lexical-address-aux exp (list (freevars exp)))))

(define lexical-address-for
  (lambda (varref list-of-decls depth)
    (if (null? list-of-decls))

(define lexical-address-aux
  (lambda (exp list-of-decls)
    ((varref? exp)
     (lexical-address-for exp list-of-decls 0))
     ((lambda? exp)
      (list 'lambda
            (lambda->paramaters exp)
            (lexical-address-aux (lambda->body exp)
                                 (cons (lambda->paramater exp) list-of-decls))))
     ((if? exp)
      (list 'if
            (lexical-address-aux (if->test exp) list-of-decls)
            (lexical-address-aux (if->then exp) list-of-decls)
            (lexical-address-aux (if->else exp) list-of-decls)))
     (else
      (map (lambda (e)
             (lexical-address-aux e list-of-decls))
           exp))

(lexical-address '(lambda (a)
                    (lambda (b c)
                      (if a b c))))
