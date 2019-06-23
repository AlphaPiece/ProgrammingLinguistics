;;;; Exercise 1.32

;;; a. Show that sum and product (exercise 1.31) are both special
;;; cases of a still more general notion called accumulate that
;;; combines a collection of terms, using some general accumulation
;;; function:
;;;
;;; (accumulate combiner null-value term a next b)
;;;
;;; Accumulate takes as arguments the same term and range
;;; specifications as sum and product, together with a combiner
;;; procedure (of two arguments) that specifies how the current
;;; term is to be combined with the accumulation of the preceding
;;; terms and a null-value that specifies what base value to use
;;; when the terms run out. Write accumulate and show how sum and
;;; product can both be defined as simple calls to accumulate.
;;;
;;; b. If your accumulate procedure generates a recursive process,
;;; write one that generates an iterative process. If it generates
;;; an iterative process, write one that generates a recursive process.

(define (accumulate-recur combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate-recur combiner
                                  null-value
                                  term
                                  (next a)
                                  next
                                  b))))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (identity x) x)

(define (inc n) (+ n 1))

(define (sum-recur term a next b)
  (accumulate-recur + 0 term a next b))

(define (product-recur term a next b)
  (accumulate-recur * 1 term a next b))

(define (sum-integers-recur a b)
  (sum-recur identity a inc b))

(define (factorial-recur n)
  (product-recur identity 1 inc n))

(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b))

(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))

(define (sum-integers-iter a b)
  (sum-iter identity a inc b))

(define (factorial-iter n)
  (product-iter identity 1 inc n))

(sum-integers-recur 1 10)
(sum-integers-iter 1 10)
(factorial-recur 6)
(factorial-iter 6)
