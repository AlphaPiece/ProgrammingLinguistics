;;;; Exercise 2.56

;;; Show how to extend the basic differentiator to handle more kinds of
;;; expressions. For instance, implement the differentiation rule
;;;
;;; d(u^n) / dx = n * u^(n - 1) * (du / dx)
;;;
;;; by adding a new clause to the deriv program and defining appropriate
;;; procedures exponentiation?, base, exponent, and make-exponentiation.
;;; (You may use the symbol ** to denote exponentiation.) Build in the
;;; rules that anything raised to the power 0 is 1 and anything raised to
;;; the power 1 is the thing itself.

(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr)
         (if (same-variable? expr var) 1 0))
        ((sum? expr)
         (make-sum (deriv (addend expr) var)
                   (deriv (augend expr) var)))
        ((product? expr)
         (make-sum
           (make-product (multiplier expr)
                         (deriv (multiplicand expr) var))
           (make-product (deriv (multiplier expr) var)
                         (multiplicand expr))))
        ((exponentiation? expr)
         (make-product
           (make-product (exponent expr)
                         (make-exponentiation (base expr)
                                              (make-sum
                                                (exponent expr)
                                                -1)))
           (deriv (base expr) var)))
        (else
          (error "unknown experssion type -- DERIV" expr))))

(define (variable? e) (symbol? e))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? expr num)
  (and (number? expr) (= expr num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
(define (addend e) (cadr e))
(define (augend e) (caddr e))
(define (sum? e)
  (and (pair? e) (eq? (car e) '+)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
(define (multiplier e) (cadr e))
(define (multiplicand e) (caddr e))
(define (product? e)
  (and (pair? e) (eq? (car e) '*)))

(define (make-exponentiation base exponent)
  (cond ((or (=number? base 1) (=number? exponent 0)) 1)
        ((=number? exponent 1) base)
        (else (list '** base exponent))))
(define (base e) (cadr e))
(define (exponent e) (caddr e))
(define (exponentiation? e)
  (and (pair? e) (eq? (car e) '**)))

(make-exponentiation 1 1000)
(make-exponentiation 12345 0)
(make-exponentiation 33 1)

(deriv '(** x 3) 'x)
(deriv '(+ (* 5 (** x 4)) (* 3 (** x 2))) 'x)
