;;; 1.1.4

(define (square x)
  (* x x))

;;; 1.1.7

(define (average x y)
  (/ (+ x y) 2))

;;; 1.1.8

(define (sqrt x)
  (define (good-enough? guess)
    (= (improve guess) guess))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))

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
