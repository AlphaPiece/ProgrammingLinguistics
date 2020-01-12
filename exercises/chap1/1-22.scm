;;;; Exercise 1.22

;;; Most Lisp implementations include a primitive called runtime that
;;; returns an integer that specifies the amount of time the system has been
;;; running (measured, for example, in microseconds). The following
;;; timed-prime-test procedure, when called with an integer n, prints n and
;;; checks to see if n is prime. If n is prime, the procedure prints three
;;; asterisks followed by the amount of time used in performing the test.

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
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

;;; (timed-prime-test 17)
;;; (timed-prime-test 143)
;;; (timed-prime-test 167)
;;; (timed-prime-test 67280421310721)

;;; Using this procedure, write a procedure search-for-primes that checks
;;; the primality of consecutive odd integers in a specified range. Use your
;;; procedure to find the three smallest primes larger than 1000; larger
;;; than 10,000; larger than 100,000; larger than 1,000,000. Note the time
;;; needed to test each prime. Since the testing algorithm has order of
;;; growth of Θ(√n), you should expect that testing for primes around 10,000
;;; should take about √10 times as long as testing for primes around 1000.
;;;
;;; Do your timing data bear this out? How well do the data for 100,000 and
;;; 1,000,000 support the √n prediction? Is your result compatible with the
;;; notion that programs on your machine run in time proportional to the
;;; number of steps required for the computation?

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

;;; (search-for-primes 1000 1050)
;;; The three smallest primes larger than 1000:
;;; 1009, 1013, 1015.

;;; (search-for-primes 10000 10050)
;;; The three samllest primes larger than 10000:
;;; 10007, 10009, 10037.

;;; (search-for-primes 100000 100050)
;;; The three samllest primes larger than 100000:
;;; 100003, 100019, 100043.

;;; (search-for-primes 1000000 1000050)
;;; The three samllest primes larger than 1000000:
;;; 1000003, 1000033, 1000037.

(search-for-primes 1000000000 1000000021)       ; 1e9 
(search-for-primes 10000000000 10000000061)     ; 1e10 
(search-for-primes 100000000000 100000000057)   ; 1e11 
(search-for-primes 1000000000000 1000000000063) ; 1e12

;;; 1000000007 *** 1.9999999999999997e-2
;;; 1000000009 *** 2.0000000000000004e-2
;;; 10000000019 *** .07
;;; 10000000033 *** .07
;;; 100000000003 *** .22
;;; 100000000019 *** .21000000000000002
;;; 1000000000039 *** .6799999999999999
;;; 1000000000061 *** .6599999999999999

;;; From our timing data, we can observe that, when increasing the tested
;;; number of a factor 10, the required time increases roughly of a factor 3.
;;; By noting that 3 ≅ √10, we can confirm both the growth prediction and the
;;; notion that programs run in a time proportional to the steps required for
;;; the computation.
