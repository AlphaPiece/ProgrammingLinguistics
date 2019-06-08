;;; Design a procedure that evolves an iterative exponentiation process that 
;;; uses successive squaring and uses a logarithmic number of steps, as does
;;; fast-expt-recur.
;;;
;;; (Hint: Using the observation that (b^(n/2))^2 = (b^2)^(n/2) , keep,
;;; along with the exponent n and the base b, an additional state variable a,
;;; and define the state transformation in such a way that the product a b n is
;;; unchanged from state to state. At the beginning of the process a is taken
;;; to be 1, and the answer is given by the value of a at the end of the
;;; process. In general, the technique of defining an invariant quantity that
;;; remains unchanged from state to state is a powerful way to think about
;;; the design of iterative algorithms.)

(define (fast-expt-iter b n)
  (define (iter a b n)
    (cond ((= n 0) a)
          ((even? n) (iter a (square b) (/ n 2)))
          (else (iter (* a b) b (- n 1)))))
  (iter 1 b n))

(fast-expt-iter 3 4)
(fast-expt-iter 2 6)
(fast-expt-iter 2 0)
(fast-expt-iter 2 1)
(fast-expt-iter 2 2)
(fast-expt-iter 2 4)
(fast-expt-iter 2 8)
(fast-expt-iter 2 16)
(fast-expt-iter 2 3)
(fast-expt-iter 2 5)
(fast-expt-iter 2 10)
(fast-expt-iter 2 20)