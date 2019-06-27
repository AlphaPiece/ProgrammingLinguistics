;;;; Exercise 1.30

;;; The sum procedure above generates a linear recursion.
;;; The procedure can be rewritten so that the sum is performed
;;; iteratively. Show how to do this by filling in the missing
;;; expressions in the following definition:

(define (cube x)
  (* x x x))

(define (inc n)
  (+ n 1))

;;; Recursive Process
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (sum-cubes a b)
  (sum cube a inc b))

(sum-cubes 1 10)

;;; Iterative Process
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (sum-cubes a b)
  (sum cube a inc b))

(sum-cubes 1 10)
