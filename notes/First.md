# Chapter 1

## What is a language?

Many different

## What is a paradigm



## Goals of the course

* Write a functional program
* Distinguish from a non-functional program
* Explain how programming features behave
* Implement an interpreter for features we learn
* Be able to compare language designs better

### Undicipledned Transfers of Control

* Side-effecting
* Implicit arguments/values
* Default values
* Too much detail (or too much abstraction)

### Things reuired in (almost) all languages

* _Primitive_ Expressions
* Means of _combining_
* Means of _abstracting_ detail away

### Learn you a scheme

#### Primitives

* Literals (numbers, boolean, strings, symbols)
* Variable (accumulator)
* Procedure (StringOps, BooleanOps, etc..)
* Special forms

#### Special Forms

* define
* if -- (you only need this _or_ cond, not both)
* lambda
* let -- syntactic abstraction
* cond
* set!
* begin
* quote

#### Operator Application

* Only one way, fully parenthesized prefix oper
* (operand ... operand ... operand ...)

    Name
    (define a 10)

    Procedure

#### Syntax

    > 25
    25     -- int
    > #t
    #t     -- true
    > #f
    #f     -- false
    > 'c
    'c     -- Smybol

    > 'my-symbol
    'my-symbol
    > 'student->name
    'student->name

    (+ 12 1)
    (+ 12 (- 5 1))

    > (min 1 2 3)
    1
    > (max 1 2 3)
    3

## Abstractions
