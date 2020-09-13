;;;; Exercise 2.80

;;; Define a generic predicate =zero? that tests if its argument is zero,
;;; and install it in the generic arithmetic package. This operation should
;;; work for ordinary numbers, rational numbers, and complex numbers.

(define (=zero? x) (apply-generic '=zero? x))

;;; Inside install-scheme-number-package
(put '=zero? '(scheme-number)
     (lambda (x) (= x 0)))

;;; Inside install-rational-package:
(put '=zero? '(rational)
     (lambda (x) (= (numer x) 0)))

;;; Inside install-complex-package:
(put '=zero? '(complex)
     (lambda (x) (= (real-part x) (imag-part x) 0)))
