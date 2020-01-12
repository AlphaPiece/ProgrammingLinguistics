;;;; Exercise 2.3

;;; Implement a representation for rectangles in a plane.
;;;
;;; (Hint: You may want to make use of exercise 2.2.) In terms of
;;; your constructors and selectors, create procedures that compute
;;; the perimeter and the area of a given rectangle. Now implement
;;; a different representation for rectangles. Can you design your
;;; system with suitable abstraction barriers, so that the same
;;; perimeter and area procedures will work using either
;;; representation?

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment p1 p2) (cons p1 p2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))
(define (length-segment s)
  (sqrt (+ (square (- (x-point (end-segment s))
                      (x-point (start-segment s))))
           (square (- (y-point (end-segment s))
                      (y-point (start-segment s)))))))

;;; Implementation 1: Build rectangles with sides parallel to
;;; axes. The internal representation of this type of rectangles
;;; is a set of two points: left-bottom point and right-top point.

(define (make-rect left-bottom right-top)
  (cons left-bottom right-top))
(define (left-bottom-rect rect)
  (car rect))
(define (right-top-rect rect)
  (cdr rect))
(define (left-top-rect rect)
  (make-point (car (car rect)) (cdr (cdr rect))))
(define (right-bottom-rect rect)
  (make-point (car (cdr rect)) (cdr (car rect))))

(define (length-rect rect)
  (- (x-point (right-top-rect rect))
     (x-point (left-bottom-rect rect))))
(define (width-rect rect)
  (- (y-point (right-top-rect rect))
     (y-point (left-bottom-rect rect))))

(define (perimeter-rect rect)
  (* 2 (+ (length-rect rect) (width-rect rect))))
(define (area-rect rect)
  (* (length-rect rect) (width-rect rect)))

(define (print-rect rect)
  (define (print-top-bottom)
    (define (iter i n)
      (if (<= i n)
          (begin (display "--")
                 (iter (+ i 1) n))))
    (iter 1 (length-rect rect))
    (newline))
  (define (print-body)
    (define (print-space n)
      (if (>= n 0)
          (begin (display "  ")
                 (print-space (- n 1)))))
    (define (print-layer)
      (display "|")
      (print-space (- (length-rect rect) 2))
      (display "|")
      (newline))
    (define (iter i n)
      (if (<= i n)
          (begin (print-layer)
                 (iter (+ i 1) n))))
    (iter 1 (- (width-rect rect) 2)))
  (newline)
  (newline)
  (print-top-bottom)
  (print-body)
  (print-top-bottom)
  (newline))

(define p1 (make-point 0 0))
(define p2 (make-point 4 6))
(define rect (make-rect p1 p2))
(perimeter-rect rect)
(area-rect rect)
(print-rect rect)

;;; Implementation 2: Build rectangles with side not necessarily
;;; parallel to axes. The internal representation of this type
;;; of rectangles is a set of four connected segments.

(define (make-rect top bottom left right)
  (cons (cons top bottom) (cons left right)))

(define (top-side-rect rect)
  (car (car rect)))
(define (bottom-side-rect rect)
  (cdr (car rect)))
(define (left-side-rect rect)
  (car (cdr rect)))
(define (right-side-rect rect)
  (cdr (cdr rect)))

(define (length-rect rect)
  (length-segment (top-side-rect rect)))
(define (width-rect rect)
  (length-segment (left-side-rect rect)))

(define (rect-perimeter rect)
  (* 2 (+ (length-rect rect) (width-rect rect))))
(define (rect-area rect)
  (* (length-rect rect) (width-rect rect)))

(define p3 (make-point 0 6))
(define p4 (make-point 4 0))
(define s1 (make-segment p3 p2))
(define s2 (make-segment p1 p4))
(define s3 (make-segment p1 p3))
(define s4 (make-segment p4 p2))
(define rect (make-rect s1 s2 s3 s4))
(rect-perimeter rect)
(rect-area rect)

;;; Thus, the same perimeter and area procedures work using either
;;; representation.
