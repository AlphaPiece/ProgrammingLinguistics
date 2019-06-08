;;; 1.2.1

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

;;; 1.2.2

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

;;; 1.2.4

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

(define (even? n)
  (= (remainder n 2) 0))

;;; Θ(log(n)) steps and Θ(log(n)) space.
(define (fast-expt-recur b n)
  (cond ((= n 0) 1)
		((even? n) (square (fast-expt-recur b (/ n 2)))
	    (else (* b (fast-expt-recur b (- n 1)))))))
