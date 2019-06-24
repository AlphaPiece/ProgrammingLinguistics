;;;; Exercise 1.39

;;; A continued fraction representation of the tangent function
;;; was published in 1770 by the German mathematician J.H. Lambert:
;;;
;;;                    x
;;; tan(x) = ---------------------
;;;                     x^2
;;;           1 - ---------------
;;;                       x^2
;;;                3 - ---------
;;;                     5 - ...
;;;
;;; where x is in radians.
;;;
;;; Define a procedure (tan-cf x k) that computes an approximation
;;; to the tangent function based on Lambert’s formula. K specifies
;;; the number of terms to compute, as in exercise 1.37.

(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1)
              (/ (n i)
                 (+ (d i) result)))))
  (iter k 0))

(define (tan-cf x k)
  (let ((y (- (* x x))))
    (cont-frac (lambda (i) (if (= i 1) x y))
               (lambda (i) (- (* i 2) 1))
               k)))

(tan-cf 4.0 20)
