;;;; Exercise 1.11

;;; A function f is defined by the rule that
;;;
;;; f(n) = n if n < 3 and
;;; f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n > 3.
;;;
;;; Write a procedure that computes f by means of a recursive process.
;;; Write a procedure that computes f by means of an iterative process.

;;; Recursive Process
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

(f 1)
(f 2)
(f 3)
(f 4)
(f 5)
(f 6)

;;; Iterative Process
(define (f n)
  (define (iter a b c counter)
    (if (>= counter n)
        a
        (iter b
              c
              (+ c (* 2 b) (* 3 a))
              (+ counter 1))))
  (if (< n 3)
      n
      (iter 0 1 2 0)))

(f 1)
(f 2)
(f 3)
(f 4)
(f 5)
(f 6)
