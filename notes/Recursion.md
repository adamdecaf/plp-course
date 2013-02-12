# Recursion

## Structrual Recursion

## Adaptor Methods

Interface Method

## __ Recursion

    ;; Replace all 'a with 'b
    (subst 'a 'b lyst)

    ;; Example
    (subst 'a 'b '((a b) (((b g r) (f r)) c (d e)) b))

```
(define subst
  (lambda (new old slist)
    (if (null? slist)
      '()
      (cons
        (if (symbol? (car slist))
          (if (eq? old (car slist)) new (car slist))
          (subst new old (car slist))
        (subst new old (cdr slist)))))))
```

## Mutual Recursion

Having two methods that call each other.

```
(define subst
 (lambda (new old slist)
   (if (null? slist)
     '()
     (cons
       (substr-sym-exp new old (car slist))
       (subst new old (cdr slist))))))

(define substr-sym-exp
  (lambda (new old exp)
    (if (symbol? exp)
      (if (eq? old exp) new exp)
      (subst new old slist))))
```

## S-List

An S-List is a list that has symbols.

    s-list            ::= () | (symbol-expression . s-list)
    symbol-expression ::= symbol | s-list
