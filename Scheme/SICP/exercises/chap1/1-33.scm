;;;; Exercise 1.33

;;; Exercise 1.33. You can obtain an even more general version
;;; of accumulate (exercise 1.32) by introducing the notion of
;;; a filter on the terms to be combined. That is, combine only
;;; those terms derived from values in the range that satisfy a
;;; specified condition. The resulting filtered-accumulate
;;; abstraction takes the same arguments as accumulate, together
;;; with an additional predicate of one argument that specifies
;;; the filter. Write filtered-accumulate as a procedure. Show
;;; how to express the following using filtered-accumulate:
;;;
;;; a. the sum of the squares of the prime numbers in the
;;; interval a to b (assuming that you have a prime? predicate
;;; already written);
;;;
;;; b. the product of all the positive integers less than n that
;;; are relatively prime to n (i.e., all positive integers i < n
;;; such that GCD(i,n) = 1).

(define (filtered-accumulate-recur combine
                                   satisfy?
                                   null-value
                                   term
                                   a
                                   next
                                   b)
  (if (> a b)
      null-value
      (combine (if (satisfy? a)
                   (term a)
                   null-value)
               (filtered-accumulate-recur combine
                                          satisfy?
                                          null-value
                                          term
                                          (next a)
                                          next
                                          b))))

(define (filtered-accumulate-iter combine
                                  satisfy?
                                  null-value
                                  term
                                  a
                                  next
                                  b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (combine (if (satisfy? a)
                           (term a)
                           null-value)
                       result))))
  (iter a null-value))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (if (<= n 1)
      false
      (= (smallest-divisor n) n)))

(define (square x) (* x x))

(define (identity x) x)

(define (inc n) (+ n 1))

(define (sum-sq-prime-recur a b)
  (filtered-accumulate-recur + prime? 0 square a inc b))

(define (product-relatively-prime-recur n)
  (define (relatively-prime? m)
    (= (gcd m n) 1))
  (filtered-accumulate-recur * relatively-prime? 1 identity 1 inc (- n 1)))

(define (sum-sq-prime-iter a b)
  (filtered-accumulate-iter + prime? 0 square a inc b))

(define (product-relatively-prime-iter n)
  (define (relatively-prime? m)
    (= (gcd m n) 1))
  (filtered-accumulate-iter * relatively-prime? 1 identity 1 inc (- n 1)))

(sum-sq-prime-recur 1 5)
(sum-sq-prime-iter 1 5)
(product-relatively-prime-recur 10)
(product-relatively-prime-iter 10)
