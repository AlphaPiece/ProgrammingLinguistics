;;; There are two risks in using a fixed number 0.001 as the threshold for the
;;; difference between y^2 and x.
;;;
;;; For a small number x, 0.001 simply might be too largeto be a tolerance
;;; threshold.
;;;
;;; For a large number x, the program will be haning and the reason is because 
;;; (improve guess never actually improve the result because of the limitation 
;;; of bits, the "improve guess" will simply be equal to "old guess" at some 
;;; point, results in (- y^2 x) never changes and hence never reach inside
;;; the tolerance range.
;;;
;;; Solution 1:
;;; Set the threshold to be extremely small.
;;;
;;; Solution 2:
;;; Compare the difference between new guess and old guess. At some point,
;;; the difference between new guess and old guess will gurantee to be 0
;;; because the machine will not be able to represent "the averaging between
;;; a guess and (/ x guess)" using fix number of bits.
;;;
;;; The following code applies the second solution.

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
	         x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (= guess (improve guess x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9)
(sqrt 0.0001)
(sqrt 1000000000000)
(sqrt 10000000000000)
(sqrt 100000000000000)
(sqrt 0.00000000000001)
(sqrt 0.000000000000001)
(sqrt 0)
