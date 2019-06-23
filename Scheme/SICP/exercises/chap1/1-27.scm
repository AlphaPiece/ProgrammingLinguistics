;;;; Exercise 1.27

;;; Demonstrate that the Carmichael numbers listed in footnote 47 really do
;;; fool the Fermat test. That is, write a procedure that takes an integer
;;; n and tests whether a^n is congruent to a modulo n for every a < n,
;;; and try your procedure on the given Carmichael numbers.

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

(define (expmod-iter b n m)
  (define (iter a b n)
    (cond ((= n 0) a)
          ((even? n) (iter a
                           (remainder (square b) m)
                           (/ n 2)))
          (else (iter (remainder (* a b) m)
                      b
                      (- n 1)))))
  (iter 1 b n))

(define (test-fermat-congruency n)
  (define (iter a)
    (if (< a n)
        (and (= (expmod-iter a n n) a)
             (iter (+ a 1)))
        true))
  (iter 0))

(prime? 71)
(test-fermat-congruency 71)
(prime? 91)
(test-fermat-congruency 91)
(prime? 561)
(test-fermat-congruency 561)
(prime? 1105)
(test-fermat-congruency 1105)
(prime? 1729)
(test-fermat-congruency 1729)
(prime? 2465)
(test-fermat-congruency 2465)
(prime? 2821)
(test-fermat-congruency 2821)
(prime? 6601)
(test-fermat-congruency 6601)
