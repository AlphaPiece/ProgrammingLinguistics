;;;; Exercise 1.45

;;; We saw in section 1.3.3 that attempting to compute square
;;; roots by naively finding a fixed point of y ↦ x/y does not
;;; converge, and that this can be fixed by average damping.
;;; The same method works for finding cube roots as fixed points
;;; of the average-damped y ↦ x/y^2 . Unfortunately, the process
;;; does not work for fourth roots -- a single average damp is
;;; not enough to make a fixed-point search for y ↦ x/y^3 converge.
;;; On the other hand, if we average damp twice (i.e., use the
;;; average damp of the average damp of y ↦ x/y^3) the fixed-point
;;; search does converge. Do some experiments to determine how
;;; many average damps are required to compute nth roots as a
;;; fixed-point search based upon repeated average damping of
;;; y ↦ x/y^(n-1). Use this to implement a simple procedure for
;;; computing nth roots using fixed-point, average-damp, and the
;;; repeated procedure of exercise 1.43. Assume that any arithmetic
;;; operations you need are available as primitives.

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (average x y)
  (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter g i)
    (if (= i n)
        g
        (iter (compose f g) (+ i 1))))
  (iter f 1))

;;; Recursive Process
(define (power b n)
  (if (= n 0)
      1
      (* b (power b (- n 1)))))

;;; Iterative Process
(define (power b n)
  (define (iter a i)
    (if (= i n)
        a
        (iter (* a b) (+ i 1))))
  (iter 1 0))

(define (fourth-root x)
  (fixed-point-of-transform (lambda (y) (/ x (power y 3)))
                            (repeated average-damp 2)
                            1.0))

(fourth-root 81)

(define (fifth-root x)
  (fixed-point-of-transform (lambda (y) (/ x (power y 4)))
                            (repeated average-damp 2)
                            1.0))

(fifth-root 32)

(define (sixth-root x)
  (fixed-point-of-transform (lambda (y) (/ x (power y 5)))
                            (repeated average-damp 2)
                            1.0))

(sixth-root 64)

(define (seventh-root x)
  (fixed-point-of-transform (lambda (y) (/ x (power y 6)))
                            (repeated average-damp 2)
                            1.0))

(seventh-root 128)

(define (eighth-root x)
  (fixed-point-of-transform (lambda (y) (/ x (power y 7)))
                            (repeated average-damp 3)
                            1.0))

(eighth-root 256)

;;; According to the experiences, we can conclude that nth-root
;;; requires (log_2(n))-fold average-damp.

(define (log2 n)
  (/ (log n) (log 2)))

(define (nth-root n x)
  (fixed-point-of-transform (lambda (y) (/ x (power y (- n 1))))
                            (repeated average-damp (floor (log2 n)))
                            1.0))

(nth-root 8 256)
(nth-root 15 32768)
(nth-root 16 65536)
