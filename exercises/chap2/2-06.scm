;;;; Exercise 2.6

;;; In case representing pairs as procedures wasn’t mind-boggling
;;; enough, consider that, in a language that can manipulate
;;; procedures, we can get by without numbers (at least insofar
;;; as nonnegative integers are concerned) by implementing 0 and
;;; the operation of adding 1 as

(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;;; This representation is known as Church numerals, after its
;;; inventor, Alonzo Church, the logician who invented the lambda
;;; calculus.
;;;
;;; Define one and two directly (not in terms of zero and add-1).
;;; (Hint: Use substitution to evaluate (add-1 zero)). Give a direct
;;; definition of the addition procedure + (not in terms of repeated
;;; application of add-1).

(define one (lambda (f) (lambda (x) (f x))))

;;; (add-1 zero)
;;; (lambda (f) (lambda (x) (f ((zero f) x))))
;;; (lambda (f) (lambda (x) (f ((lambda (x) x) x))))
;;; (lambda (f) (lambda (x) (f x)))

(define two (lambda (f) (lambda (x) (f (f x)))))

;;; (add-1 one)
;;; (lambda (f) (lambda (x) (f ((one f) x))))
;;; (lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
;;; (lambda (f) (lambda (x) (f (f x))))

;;; Notice that a number n is a procedure that takes as inputs a
;;; procedure that computes f and returns the procedure that computes
;;; the nth repeated application of f.

(define three (lambda (f) (lambda (x) (f (f (f x))))))

(define (+ a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))

;;; (+ two one)
;;; (lambda (f) (lambda (x) ((two f) ((one f) x))))
;;; (lambda (f) (lambda (x) ((two f) ((lambda (x) (f x)) x))))
;;; (lambda (f) (lambda (x) ((two f) (f x))))
;;; (lambda (f) (lambda (x) ((lambda (x) (f (f x))) (f x))))
;;; (lambda (f) (lambda (x) (f (f (f x)))))
;;; three
