;;;; Exercise 1.46

;;; Several of the numerical methods described in this chapter
;;; are instances of an extremely general computational strategy
;;; known as iterative improvement. Iterative improvement says
;;; that, to compute something, we start with an initial guess
;;; for the answer, test if the guess is good enough, and otherwise
;;; improve the guess and continue the process using the improved
;;; guess as the new guess. Write a procedure iterative-improve
;;; that takes two procedures as arguments: a method for telling
;;; whether a guess is good enough and a method for improving a
;;; guess. Iterative-improve should return as its value a procedure
;;; that takes a guess as argument and keeps improving the guess
;;; until it is good enough. Rewrite the sqrt procedure of section
;;; 1.1.7 and the fixed-point procedure of section 1.3.3 in terms
;;; of iterative-improve.

(define (iterative-improve good-enough? improve)
  (define (try guess)
    (if (good-enough? guess)
        guess
        (try (improve guess))))
  try)

(define (average x y)
  (/ (+ x y) 2))
(define (sqrt x)
  (define (good-enough? guess)
    (= (improve guess) guess))
  (define (improve guess)
    (average guess (/ x guess)))
  ((iterative-improve good-enough? improve) 1.0))

(sqrt 2)

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (good-enough? guess)
    (< (abs (- guess (f guess))) tolerance))
  ((iterative-improve good-enough? f) first-guess))

(fixed-point cos 1.0)
