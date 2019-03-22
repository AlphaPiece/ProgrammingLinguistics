;;; A test to determine whether the interpreter I'm faced with is using
;;; applicative-order evaluation or normal-order evaluation.

(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

;;; If the interpreter is applicative-order evaluation, the program will
;;; run forever. (Since the interpreter needs to get the value of each
;;; argument and (p) is infinitely expanded to itself.)
;;;
;;; If the interpreter is normal-order evaluation, the interpreter will 
;;; not evaluate (p) until it actually needs its value. Therefore the
;;; program will terminate smoothly.
