;;;; Exercise 1.30

;;; The sum procedure above generates a linear recursion.
;;; The procedure can be rewritten so that the sum is performed
;;; iteratively. Show how to do this by filling in the missing
;;; expressions in the following definition:

(define (sum-recur term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum-recur term (next a) next b))))

(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (cube x)
  (* x x x))

(define (inc n)
  (+ n 1))

(define (sum-cubes-recur a b)
  (sum-recur cube a inc b))

(define (sum-cubes-iter a b)
  (sum-iter cube a inc b))

(sum-cubes-recur 1 10)
(sum-cubes-iter 1 10)
