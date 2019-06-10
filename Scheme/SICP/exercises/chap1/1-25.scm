;;; Alyssa P. Hacker complains that we went to a lot of extra work in
;;; writingexpmod. After all, she says, since we already know how to compute
;;; exponentials, we could have simply written:

(define (fast-expt-recur b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt-recur b (/ n 2))))
        (else (* b (fast-expt-recur b (- n 1))))))

(define (expmod base exp m)
  (remainder (fast-expt-recur base exp) m))

;;; Is she correct? Would this procedure serve as well for our fast prime
;;; tester? Explain.

(define (square x)
  (newline)
  (display "square ")
  (display x)
  (* x x))

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

(expmod-recur 18 123456789 98765)
(expmod-iter 18 123456789 98765)

(expmod 5 101 101)
(expmod-recur 5 101 101)
(expmod-iter 5 101 101)

;;; (expmod-recur 5 101 101)
;;; square 5
;;; square 24
;;; square 71
;;; square 92
;;; square 1
;;; square 1
;;; ;Value: 5
;;;
;;; (expmod-iter 5 101 101)
;;; square 5
;;; square 25
;;; square 19
;;; square 58
;;; square 31
;;; square 52
;;; ;Value: 5
;;;
;;; (expmod 5 101 101)
;;; square 5
;;; square 125
;;; square 15625
;;; square 244140625
;;; square 298023223876953125
;;; square 88817841970012523233890533447265625
;;; ;Value: 5

;;; No, she is wrong. Since the procedure square will consume a lot of time
;;; when it computes large numbers. The remainder procedure in expmod-recur
;;; keeps the numbers being sqaured less than the number tested for primality m.
