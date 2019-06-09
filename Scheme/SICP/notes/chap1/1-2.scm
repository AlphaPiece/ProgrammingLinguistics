;;;
;;; 1.2.1
;;;

(define (factorial-recur n)
  (if (= n 1)
      1
      (* n (factorial-recur (- n 1)))))

(define (factorial-iter n)
  (define (iter product counter)
    (if (> counter n)
	    product
		(iter (* product counter)
		      (+ counter 1))))
  (iter 1 1))

(factorial-recur 5)
(factorial-iter 5)
(factorial-recur 7)
(factorial-iter 7)

;;;
;;; 1.2.2
;;;

(define (fib-recur n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
		(else (+ (fib-recur (- n 1))
		         (fib-recur (- n 2))))))

(define (fib-iter n)
  (define (iter a b counter)
    (if (= counter n)
	    a
		(iter b (+ a b) (+ counter 1))))
  (iter 0 1 0))

(fib-recur 5)
(fib-iter 5)
(fib-recur 7)
(fib-iter 7)

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

;;; Θ(n) steps and Θ(n) space.
(define (expt-recur b n)
  (if (= n 0)
	  1
	  (* b (expt-recur b (- n 1)))))

;;; Θ(n) steps and Θ(1) space.
(define (expt-iter b n)
  (define (iter product counter)
	(if (= counter n)
	    product
		(iter (* product b)
			  (+ counter 1))))
  (iter 1 0))

(expt-recur 2 6)
(expt-iter 2 6)
(expt-recur 3 3)
(expt-iter 3 3)

(define (even? n)
  (= (remainder n 2) 0))

;;; Θ(log(n)) steps and Θ(log(n)) space.
(define (fast-expt-recur b n)
  (cond ((= n 0) 1)
		((even? n) (square (fast-expt-recur b (/ n 2))))
	    (else (* b (fast-expt-recur b (- n 1))))))

(fast-expt-recur 3 4)
(fast-expt-recur 10 3)

;;; Fast-expt-iter is implemented in exercise 1-16.

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
    (cond ((= n 0) (remainder a m))
          ((even? n) (iter a (square b) (/ n 2)))
          (else (iter (* a b) b (- n 1)))))
  (iter 1 b n))

(expmod-recur 2 6 6)
(expmod-iter 2 6 6)
(expmod-recur 5 7 13)
(expmod-iter 5 7 13)

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))
