;;;; Exercise 1.4

;;; Observe that our model of evaluation allows for combinations whose
;;; operators are compound expressions. Use this observation to describe the
;;; behavior of the following procedure.

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;;; If b > 0, then return "+" as the operator of a and b, otherwise "-".
;;; So this procedure will always return the sum of a and the absolute value
;;; of b.
