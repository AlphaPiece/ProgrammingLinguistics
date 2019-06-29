;;;; Exercise 2.11

;;; In passing, Ben also cryptically comments: "By testing the signs
;;; of the endpoints of the intervals, it is possible to break
;;; mul-interval into nine cases, only one of which requires more
;;; than two muliplications." Rewrite this procedure using Ben’s
;;; suggestion.

(define (make-interval a b)
  (if (> a b)
      (cons b a)
      (cons a b)))
(define (lower-bound z) (car z))
(define (upper-bound z) (cdr z))

(define (print-interval z)
  (newline)
  (display "[")
  (display (lower-bound z))
  (display ",")
  (display (upper-bound z))
  (display "]"))

;;;    (a b) (c d)
;;; 1. (+ +) (+ +) -> (ac bd)
;;; 2. (+ +) (- +) -> (bc bd)
;;; 3. (+ +) (- -) -> (bc ad)
;;; 4. (- +) (+ +) -> 2
;;; 5. (- +) (- +) -> (min(ad,bc) max(ac,bd))
;;; 6. (- +) (- -) -> (bc ac)
;;; 7. (- -) (+ +) -> 3
;;; 8. (- -) (- +) -> 6
;;; 9. (- -) (- -) -> (bd ac)
;;;
;;; Note that '+' represents non-negative number, i.e., includes 0.

(define (mul-19 x y)
  (make-interval (* (lower-bound x) (lower-bound y))
                 (* (upper-bound x) (upper-bound y))))
(define (mul-24 x y)
  (make-interval (* (upper-bound x) (lower-bound y))
                 (* (upper-bound x) (upper-bound y))))
(define (mul-37 x y)
  (make-interval (* (upper-bound x) (lower-bound y))
                 (* (lower-bound x) (upper-bound y))))
(define (mul-5 x y)
  (make-interval (min (* (lower-bound x) (upper-bound y))
                      (* (upper-bound x) (lower-bound y)))
                 (max (* (lower-bound x) (lower-bound y))
                      (* (upper-bound x) (upper-bound y)))))
(define (mul-68 x y)
  (make-interval (* (upper-bound x) (lower-bound y))
                 (* (lower-bound x) (lower-bound y))))

(define (case-1 x y)
  (and (>= (lower-bound x) 0)
       (>= (upper-bound x) 0)
       (>= (lower-bound y) 0)
       (>= (upper-bound y) 0)))
(define (case-2 x y)
  (and (>= (lower-bound x) 0)
       (>= (upper-bound x) 0)
       (< (lower-bound y) 0)
       (>= (upper-bound y) 0)))
(define (case-3 x y)
(and (>= (lower-bound x) 0)
     (>= (upper-bound x) 0)
     (< (lower-bound y) 0)
     (< (upper-bound y) 0)))
(define (case-4 x y)
  (and (< (lower-bound x) 0)
       (>= (upper-bound x) 0)
       (>= (lower-bound y) 0)
       (>= (upper-bound y) 0)))
(define (case-5 x y)
  (and (< (lower-bound x) 0)
       (>= (upper-bound x) 0)
       (< (lower-bound y) 0)
       (>= (upper-bound y) 0)))
(define (case-6 x y)
  (and (< (lower-bound x) 0)
       (>= (upper-bound x) 0)
       (< (lower-bound y) 0)
       (< (upper-bound y) 0)))
(define (case-7 x y)
  (and (< (lower-bound x) 0)
       (< (upper-bound x) 0)
       (>= (lower-bound y) 0)
       (>= (upper-bound y) 0)))
(define (case-8 x y)
  (and (< (lower-bound x) 0)
       (< (upper-bound x) 0)
       (< (lower-bound y) 0)
       (>= (upper-bound y) 0)))
(define (case-9 x y)
  (and (< (lower-bound x) 0)
       (< (upper-bound x) 0)
       (< (lower-bound y) 0)
       (< (upper-bound y) 0)))

(define (mul-interval x y)
  (cond ((or (case-1 x y) (case-9 x y)) (mul-19 x y))
        ((case-2 x y) (mul-24 x y))
        ((case-3 x y) (mul-37 x y))
        ((case-4 x y) (mul-24 y x))
        ((case-5 x y) (mul-5 x y))
        ((case-6 x y) (mul-68 x y))
        ((case-7 x y) (mul-37 y x))
        ((case-8 x y) (mul-68 y x))))

;;; Case 1
;;; Result: [3,8]
(print-interval (mul-interval (make-interval 1 2)
                              (make-interval 3 4)))
;;; Case 2
;;; Result: [-6,8]
(print-interval (mul-interval (make-interval 1 2)
                              (make-interval -3 4)))
;;; Case 3
;;; Result: [-8,-3]
(print-interval (mul-interval (make-interval 1 2)
                              (make-interval -4 -3)))
;;; Case 4
;;; Result: [-4,8]
(print-interval (mul-interval (make-interval -1 2)
                              (make-interval 3 4)))
;;; Case 5
;;; Result: [-6,8]
(print-interval (mul-interval (make-interval -1 2)
                              (make-interval -3 4)))
;;; Case 6
;;; Result: [-8,4]
(print-interval (mul-interval (make-interval -1 2)
                              (make-interval -4 -3)))
;;; Case 7
;;; Result: [-8,-3]
(print-interval (mul-interval (make-interval -2 -1)
                              (make-interval 3 4)))
;;; Case 8
;;; Result: [-8,6]
(print-interval (mul-interval (make-interval -2 -1)
                              (make-interval -3 4)))
;;; Case 9
;;; Result: [3,8]
(print-interval (mul-interval (make-interval -2 -1)
                              (make-interval -4 -3)))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

;;; Case 1
;;; Result: [3,8]
(print-interval (mul-interval (make-interval 1 2)
                              (make-interval 3 4)))
;;; Case 2
;;; Result: [-6,8]
(print-interval (mul-interval (make-interval 1 2)
                              (make-interval -3 4)))
;;; Case 3
;;; Result: [-8,-3]
(print-interval (mul-interval (make-interval 1 2)
                              (make-interval -4 -3)))
;;; Case 4
;;; Result: [-4,8]
(print-interval (mul-interval (make-interval -1 2)
                              (make-interval 3 4)))
;;; Case 5
;;; Result: [-6,8]
(print-interval (mul-interval (make-interval -1 2)
                              (make-interval -3 4)))
;;; Case 6
;;; Result: [-8,4]
(print-interval (mul-interval (make-interval -1 2)
                              (make-interval -4 -3)))
;;; Case 7
;;; Result: [-8,-3]
(print-interval (mul-interval (make-interval -2 -1)
                              (make-interval 3 4)))
;;; Case 8
;;; Result: [-8,6]
(print-interval (mul-interval (make-interval -2 -1)
                              (make-interval -3 4)))
;;; Case 9
;;; Result: [3,8]
(print-interval (mul-interval (make-interval -2 -1)
                              (make-interval -4 -3)))
