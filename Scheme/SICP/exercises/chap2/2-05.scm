;;;; Exercise 2.5

;;; Show that we can represent pairs of nonnegative integers
;;; using only numbers and arithmetic operations if we represent
;;; the pair a and b as the integer that is the product
;;; (2^a) * (3^b).
;;;
;;; Give the corresponding definitions of the procedures
;;; cons, car, and cdr.

(define (power b n)
  (cond ((= n 0) 1)
        ((< n 0) (/ 1 (power b (- n))))
        ((even? n) (square (power b (/ n 2))))
        (else (* b (power b (- n 1))))))

(define (cons a b)
  (* (power 2 a) (power 3 b)))

(define x (cons 29 11))
x
(define y (cons 34 7))
y

;;; Implementation 1
(define (car z)
  (define (count i n)
    (if (odd? n)
        i
        (count (+ i 1) (/ n 2))))
  (count 0 z))
(define (cdr z)
  (define (count i n)
    (if (= (remainder n 3) 0)
        (count (+ i 1) (/ n 3))
        i))
  (count 0 z))

(car x)
(cdr x)
(car y)
(cdr y)

;;; Implementation 2
(define (car z)
  (if (= (remainder z 3) 0)
      (car (/ z 3))
      (round (/ (log z) (log 2)))))
(define (cdr z)
  (if (odd? z)
      (/ (log z) (log 3))
      (round (cdr (/ z 2)))))

(car x)
(cdr x)
(car y)
(cdr y)
