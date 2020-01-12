;;;; Notes for Section 1.2

;;;
;;; 1.2.1
;;;

;;; Recursive Process
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 5)
(factorial 7)

;;; Iterative Process
(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
	    product
		(iter (* product counter)
		      (+ counter 1))))
  (iter 1 1))

(factorial 5)
(factorial 7)

;;;
;;; 1.2.2
;;;

;;; Recursive Process
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
		(else (+ (fib (- n 1))
		         (fib (- n 2))))))

(fib 5)
(fib 7)

;;; Iterative Process
(define (fib-iter n)
  (define (iter a b counter)
    (if (= counter n)
	    a
		(iter b (+ a b) (+ counter 1))))
  (iter 0 1 0))

(fib 5)
(fib 7)

(define (count-change amount)
  (define (first-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)
	      ((= kinds-of-coins 2) 5)
		  ((= kinds-of-coins 3) 10)
		  ((= kinds-of-coins 4) 25)
		  ((= kinds-of-coins 5) 50)))
  (define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
	      ((or (< amount 0) (= kinds-of-coins 0)) 0)
		  (else (+ (cc amount
		               (- kinds-of-coins 1))
		           (cc (- amount
				          (first-denomination kinds-of-coins))
				       kinds-of-coins)))))
  (cc amount 5))

(count-change 100)
(count-change 10)

;;;
;;; 1.2.4
;;;

;;; Recursive Process
;;; Θ(n) steps and Θ(n) space
(define (expt b n)
  (if (= n 0)
	  1
	  (* b (expt b (- n 1)))))

(expt 2 6)
(expt 3 3)

;;; Iterative Process
;;; Θ(n) steps and Θ(1) space
(define (expt b n)
  (define (iter product counter)
	(if (= counter n)
	    product
		(iter (* product b)
			  (+ counter 1))))
  (iter 1 0))

(expt 2 6)
(expt 3 3)

(define (even? n)
  (= (remainder n 2) 0))

;;; Recursive Process
;;; Θ(log(n)) steps and Θ(log(n)) space
(define (fast-expt b n)
  (cond ((= n 0) 1)
		((even? n) (square (fast-expt b (/ n 2))))
	    (else (* b (fast-expt b (- n 1))))))

(fast-expt 3 4)
(fast-expt 10 3)

;;; Fast-expt with iterative process is implemented in exercise 1-16.

;;;
;;; 1.2.5
;;;

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(gcd 204 4)
(gcd 234 67)
(gcd 91 63)

;;;
;;; 1.2.6
;;;

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
      
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= (smallest-divisor n) n))

(prime? 7)
(prime? 47)
(prime? 121)
(prime? 5739)

;;; Recursive Process
(define (expmod b n m)
  (cond ((= n 0) 1)
        ((even? n)
         (remainder (square (expmod b (/ n 2) m))
                    m))
        (else
          (remainder (* b (expmod b (- n 1) m))
                     m))))

(expmod 2 6 6)
(expmod 5 7 13)
(expmod 101 12 43)
(expmod 5000 100003 100003)

;;; Iterative Process
(define (expmod b n m)
  (define (iter a b n)
    (cond ((= n 0) a)
          ((even? n) (iter a
                           (remainder (square b) m)
                           (/ n 2)))
          (else (iter (remainder (* a b) m)
                      b
                      (- n 1)))))
  (iter 1 b n))

(expmod 2 6 6)
(expmod 5 7 13)
(expmod 101 12 43)
(expmod 5000 100003 100003)

(define (fermat-test n)
  (define (try-it a)
    (= (expmod-recur a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))
