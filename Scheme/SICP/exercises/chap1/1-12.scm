;;;; Exercise 1.12

;;; The following pattern of numbers is called Pascal’s triangle.
;;;      1
;;;     1 1
;;;    1 2 1
;;;   1 3 3 1
;;;  1 4 6 4 1
;;;     ...
;;; The numbers at the edge of the triangle are all 1, and each number inside
;;; the triangle is the sum of the two numbers above it.
;;;
;;; Write a procedure that computes elements of Pascal’s triangle by means of
;;; a recursive process.

(define (pascal-triangle row col)
  (cond ((or (< col 1)
             (> col row))
         0)
        ((or (= col 1)
             (= col row))
         1)
        (else (+ (pascal-triangle (- row 1)
                                  (- col 1))
                 (pascal-triangle (- row 1)
                                  col)))))

(pascal-triangle 0 2)
0
(pascal-triangle 4 5)
0
(pascal-triangle 2 1)
1
(pascal-triangle 4 3)
3
(pascal-triangle 5 3)
6
(pascal-triangle 6 2)
5
