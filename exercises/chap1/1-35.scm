;;;; Exercise 1.35

;;; Show that the golden ratio ϕ (section 1.2.2) is a fixed
;;; point of the transformation x ↦ 1 + 1/x, and use this fact
;;; to compute ϕ by means of the fixed-point procedure.

;;; From section 1.2.2, we know that golden ratio satisfies
;;;
;;; ϕ^2 = ϕ + 1
;;;
;;; Divide ϕ from both sides, we have 
;;;
;;; ϕ = 1 + 1/ϕ
;;;
;;; Thus we could find the golden ratio by looking for the
;;; fixed point of the function f(x) = 1 + 1/x, i.e, the root
;;; of the equation x = 1 + 1/x.

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

(define golden-ratio (fixed-point (lambda (x) (+ 1 (/ 1 x)))
                                  1.0))

golden-ratio
