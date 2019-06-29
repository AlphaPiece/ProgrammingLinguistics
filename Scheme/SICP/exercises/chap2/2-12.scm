;;;; Exercise 2.12

;;; Define a constructor make-center-percent that takes a center
;;; and a percentage tolerance and produces the desired interval.
;;; You must also define a selector percent that produces the
;;; percentage tolerance for a given interval. The center selector
;;; is the same as the one shown above.

(define (make-interval a b)
  (if (< a b)
      (cons a b)
      (cons b a)))
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))

(define (make-center-percent c p)
  (let ((w (* c p)))
    (make-interval (- c w) (+ c w))))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (percent i)
  (/ (/ (- (upper-bound i) (lower-bound i)) 2)
     (center i)))

(define (print-center-width z)
  (let ((c (center z)))
    (newline)
    (display c)
    (display " ± ")
    (display (* c (percent z)))))

(define x (make-center-percent 3.5 0.1))
(print-center-width x)
