;;;; Exercise 1.18

;;; Using the results of exercises 1.16 and 1.17, devise a procedure that
;;; generates an iterative process for multiplying two integers in terms of
;;; adding, doubling, and halving and uses a logarithmic number of steps.

(define (double x)
  (+ x x))

(define (halve x)
  (/ x 2))

;;; Iterative Process
;;; Θ(log(b)) steps and Θ(1) space
(define (* a b)
  (define (iter p a b)
    (cond ((= b 0) p)
          ((even? b) (iter p (double a) (halve b)))
          (else (iter (+ p a) a (- b 1)))))
  (iter 0 a b))

(* 3 5)
(* 11 11)
(* 70 70)
