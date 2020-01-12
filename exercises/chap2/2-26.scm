;;;; Exercise 2.26

;;; Suppose we define x and y to be two lists:

(define x (list 1 2 3))
(define y (list 4 5 6))

;;; What result is printed by the interpreter in response to evaluating
;;; each of the following expressions:

(append x y)
;;; (1 2 3 4 5 6)
;;; Because we just append a list to the end of another.

(cons x y)
;;; ((1 2 3) 4 5 6)
;;; Because (cons x y) -> (cons x (list 4 5 6)) ->
;;; (cons x (cons 4 (cons 5 (cons 6 nil)))) -> (list x 4 5 6).

(list x y)
;;; ((1 2 3) (4 5 6))
;;; Because we just build a list of two elements.
