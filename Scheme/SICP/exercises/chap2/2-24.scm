;;;; Exercise 2.24

;;; Suppose we evaluate the expression (list 1 (list 2 (list 3 4))).
;;; Give the result printed by the interpreter, the corresponding
;;; box-and-pointer structure, and the interpretation of this as a tree
;;; (as in figure 2.6).

(define nil '())

(list 1 (list 2 (list 3 4)))

(cons 1 (cons (cons 2 (cons (cons 3 (cons 4 nil)) nil)) nil))

;;; Both are evaluated to
;;;
;;; (1 (2 (3 4)))
;;;
;;; by the interpreter.
