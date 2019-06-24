;;;; Exercise 1.38

;;; In 1737, the Swiss mathematician Leonhard Euler published
;;; a memoir De Fractionibus Continuis, which included a continued
;;; fraction expansion for e - 2, where e is the base of the
;;; natural logarithms. In this fraction, the N_i are all 1,
;;; and the D_i are successively
;;;
;;; 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ....
;;;
;;; Write a program that uses your cont-frac procedure from
;;; exercise 1.37 to approximate e, based on Euler’s expansion.

(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1)
              (/ (n i)
                 (+ (d i) result)))))
  (iter k 0))

(define euler-e
  (+ (cont-frac (lambda (i) 1.0)
                (lambda (i)
                  (let ((j (+ i 1)))
                    (if (= (remainder j 3) 0)
                        (* (/ j 3) 2)
                        1)))
                20)
     2))

euler-e
