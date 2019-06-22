;;;; Exercise 1.31

;;; a. The sum procedure is only the simplest of a vast number
;;; of similar abstractions that can be captured as higher-order
;;; procedures. Write an analogous procedure called product
;;; that returns the product of the values of a function at points
;;; over a given range. Show how to define factorial in terms of
;;; product. Also use product to compute approximations to using
;;; the formula:
;;;
;;;  π     2 * 4 * 4 * 6 * 6 * 8 * ...
;;; --- = -----------------------------
;;;  4     3 * 3 * 5 * 5 * 7 * 7 * ...
;;;
;;; b. If your product procedure generates a recursive process,
;;; write one that generates an iterative process. If it generates
;;; an iterative process, write one that generates a recursive
;;; process.

(define (product-recur term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-recur term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(define (identity x) x)

(define (inc n) (+ n 1))

(define (factorial-recur n)
  (product-recur identity 1 inc n))

(define (factorial-iter n)
  (product-iter identity 1 inc n))

(factorial-recur 0)
(factorial-iter 0)
(factorial-recur 1)
(factorial-iter 1)
(factorial-recur 4)
(factorial-iter 4)
(factorial-recur 5)
(factorial-iter 5)
(factorial-recur 6)
(factorial-iter 6)
