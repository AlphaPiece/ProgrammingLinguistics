;;;; Exercise 2.1

;;; Define a better version of make-rat that handles both
;;; positive and negative arguments. Make-rat should normalize
;;; the sign so that if the rational number is positive, both
;;; the numerator and denominator are positive, and if the
;;; rational number is negative, only the numerator is negative.

(define (make-rat n d)
  (let ((sign (if (or (and (negative? n) (negative? d))
                      (and (positive? n) (positive? d)))
                  +
                  -))
        (a (abs n))
        (b (abs d)))
    (let ((g (gcd a b)))
      (cons (sign (/ a g)) (/ b g)))))

(define (make-rat n d)
  (let ((g ((if (< d 0) - +) (abs (gcd n d)))))
    (cons (/ n g) (/ d g))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(print-rat (make-rat 6 9))      ; 2/3 
(print-rat (make-rat -6 9))     ; -2/3 
(print-rat (make-rat 6 -9))     ; -2/3 
(print-rat (make-rat -6 -9))    ; 2/3 
