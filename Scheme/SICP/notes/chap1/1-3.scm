;;;; Notes for Section 1.3

;;; 1.3.1

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (cube x)
  (* x x x))

(define (inc n)
  (+ n 1))

(define (sum-cubes a b)
  (sum cube a inc b))

(sum-cubes 1 10)

(define (identity x)
  x)

(define (sum-integers a b)
  (sum identity a inc b))

(sum-integers 1 10)

(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next n)
    (+ n 4))
  (sum pi-term a pi-next b))

(* 8 (pi-sum 1 10000))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(integral cube 0 1 0.001)
(integral cube 0 1 0.0001)

;;; 1.3.2

(define (pi-sum a b)
  (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
       a
       (lambda (x) (+ x 4))
       b))

(define (integral f a b dx)
  (* (sum f
          (+ a (/ dx 2.0))
          (lambda (x) (+ x dx))
          b)
     dx))

(define (f x y)
  (define (f-helper a b)
    (+ (* x (square a))
       (* y b)
       (* a b)))
  (f-helper (+ 1 (* x y))
            (- 1 y)))

(define (f x y)
  ((lambda (a b)
     (+ (* x (square a))
        (* y b)
        (* a b)))
   (+ 1 (* x y))
   (- 1 y)))

(define (f x y)
  (let ((a (+ 1 (* x y)))
        (b (- 1 y)))
    (+ (* x (square a))
       (* y b)
       (* a b))))

(define (f x y)
  (define a (+ 1 (* x y)))
  (define b (- 1 y))
  (+ (* x (square a))
     (* y b)
     (* a b)))

;;; 1.3.3

(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                ((negative? test-value)
                 (search f midpoint pos-point))
                (else midpoint))))))

(define (average x y)
  (/ (+ x y) 2))

(define (close-enough? x y)
  (< (abs (- x y)) 0.001))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
            (error "Values are not of opposite sign" a b)))))

(half-interval-method sin 2.0 4.0)
(half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3))
                      1.0
                      2.0)

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

(fixed-point cos 1.0)
(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0)

;;; This sqrt won't work.
(define (sqrt x)
  (fixed-point (lambda (y) (/ x y))
               1.0))

;;; A simple modification (average damping).
(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

;;; 1.3.4

(define (average-damp f)
  (lambda (x) (average x (f x))))

((average-damp square) 10)

;;; Method 1 for computing square root of x:
;;; Look for a fixed point of the average-damped
;;; version of y ↦ x/y.

(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))

(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))

;;; Method 2 for computing square root of x:
;;; Use Newton’s method that finds a fixed point of
;;; the Newton transform of y ↦ y^2 - x.

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define dx 0.00001)

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (sqrt x)
  (newtons-method (lambda (y) (- (square y) x))
                  1.0))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

;;; Method 1

(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (/ x y))
                            average-damp
                            1.0))

;;; Method 2

(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (- (square y) x))
                            newton-transform
                            1.0))
