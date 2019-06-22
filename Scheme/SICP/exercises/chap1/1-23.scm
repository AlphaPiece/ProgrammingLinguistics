;;;; Exercise 1.23

;;; The smallest-divisor procedure shown at the start of this section does lots
;;; of needless testing: After it checks to see if the number is divisible by 2
;;; there is no point in checking to see if it is divisible by any larger even
;;; numbers. This suggests that the values used for test-divisor should not be
;;; 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, ....
;;;
;;; To implement this change, define a procedure next that returns 3 if its
;;; input is equal to 2 and otherwise returns its input plus 2. Modify the
;;; smallest-divisor procedure to use (next test-divisor) instead of
;;; (+ test-divisor 1). With timed-prime-test incorporating this modified
;;; version of smallest-divisor, run the test for each of the 12 primes found
;;; in exercise 1.22. Since this modification halves the number of test steps,
;;; you should expect it to run about twice as fast. Is this expectation
;;; confirmed? If not, what is the observed ratio of the speeds of the two
;;; algorithms, and how do you explain the fact that it is different from 2?

(define (next test-divisor)
  (if (= test-divisor 2)
      3
      (+ test-divisor 2)))

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (define start-time (runtime))
  (if (prime? n)
      (begin (newline)
             (display n)
             (report-prime (- (runtime) start-time)))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start end)
  ;; Looks for primes between start and end.
  (define (check n)
    (if (odd? n)
        (timed-prime-test n))
    (iter (+ n 1)))
  (define (iter start)
    (if (< start end)
        (check start)))
  (iter start))

(search-for-primes 1000000000 1000000021)       ; 1e9
(search-for-primes 10000000000 10000000061)     ; 1e10
(search-for-primes 100000000000 100000000057)   ; 1e11
(search-for-primes 1000000000000 1000000000063) ; 1e12

;;; The observed ratio is roughly 1.5.
;;; The reason that the ratio is not exacly 2 is that we have an extra
;;; if-statement which checks a condition in every loop of find-divisor.
