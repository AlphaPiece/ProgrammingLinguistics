;;; Modify the timed-prime-test procedure of exercise 1.22 to use fast-prime?
;;; (the Fermat method), and test each of the 12 primes you found in that
;;; exercise. Since the Fermat test has Θ(log(n)) growth, how would you expect
;;; the time to test primes near 1,000,000 to compare with the time needed to
;;; test primes near 1000? Do your data bear this out? Can you explain any
;;; discrepancy you find?

(define (expmod-recur b n m)
  (cond ((= n 0) 1)
        ((even? n)
         (remainder (square (expmod-recur b (/ n 2) m))
                    m))
        (else
          (remainder (* b (expmod-recur b (- n 1) m))
                     m))))

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

(define (fermat-test n)
  (define (try-it a)
    (= (expmod-iter a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (prime? n)
  (fast-prime? n 300))

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

(timed-prime-test 1009)
(timed-prime-test 1013)
(timed-prime-test 1019)
(timed-prime-test 10007)
(timed-prime-test 10009)
(timed-prime-test 10037)
(timed-prime-test 100003)
(timed-prime-test 100019)
(timed-prime-test 100043)
(timed-prime-test 1000003)
(timed-prime-test 1000033) 
(timed-prime-test 1000037)

;;; The running times of tests above are between 0 and 0.01.

(timed-prime-test 1000000007)
(timed-prime-test 1000000009)
(timed-prime-test 1000000021)
(timed-prime-test 10000000019)
(timed-prime-test 10000000033)
(timed-prime-test 10000000061)
(timed-prime-test 100000000003)
(timed-prime-test 100000000019)
(timed-prime-test 100000000057)
(timed-prime-test 1000000000039)
(timed-prime-test 1000000000061)
(timed-prime-test 1000000000063)

;;; The running times of test above are between 0.01 and 0.02.

;;; From the collected timing data, we can observe that testing a number with
;;; twice as many digits (1e12 vs. 1e6) is roughly twice as slow. This supports
;;; the theory of logarithmic growth.
