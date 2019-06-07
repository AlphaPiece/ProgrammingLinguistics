;;; A function f is defined by the rule that
;;;;f(n) = n if n < 3 and
;;; f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n > 3.
;;;
;;; Write a procedure that computes f by means of a recursive process.
;;; Write a procedure that computes f by means of an iterative process.

(define (f-recur n)
  (if (< n 3)
      n
	  (+ (f-recur (- n 1))
	     (* 2 (f-recur (- n 2)))
		 (* 3 (f-recur (- n 3))))))

(define (f-iter n)
  (define (iter a b c counter)
    (if (>= counter n)
	    a
		(iter b
		      c
			  (+ c (* 2 b) (* 3 a))
		      (+ counter 1))))
  (if (< n 3)
      n
      (iter 0 1 2 0)))

(f-recur 1)
(f-iter 1)
(f-recur 2)
(f-iter 2)
(f-recur 3)
(f-iter 3)
(f-recur 4)
(f-iter 4)
(f-recur 5)
(f-iter 5)
(f-recur 6)
(f-iter 6)
