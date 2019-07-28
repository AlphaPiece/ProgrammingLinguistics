;;;; Exercise 2.57

;;; Extend the differentiation program to handle sums and products of
;;; arbitrary numbers of (two or more) terms. Then the last example above
;;; could be expressed as
;;;
;;; (deriv '(* x y (+ x 3)) 'x)
;;;
;;; Try to do this by changing only the representation for sums and products,
;;; without changing the deriv procedure at all. For example, the addend of
;;; a sum would be the first term, and the augend would be the sum of the
;;; rest of the terms.

(define (=number? expr num)
  (and (number? expr) (= expr num)))

(define (sum? e)
  (and (pair? e) (eq? (car e) '+)))
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
(define (addend e) (cadr e))

(define (augend e)
  (let ((rest (cddr e)))
    (if (not (pair? rest))
        rest
        (fold-right make-sum 0 rest))))

(augend '(+ 1 0 0 2 x 0 4 y))

(define (augend e)
  (if (null? (cdddr e))
      (caddr e)
      (cons '+ (cddr e))))

(augend '(+ 1 0 0 2 x 0 4 y))

(define (product? e)
  (and (pair? e) (eq? (car e) '*)))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
(define (multiplier e) (cadr e))

(define (multiplicand e)
  (let ((rest (cddr e)))
    (if (not (pair? rest))
        rest
        (fold-right make-product 1 rest))))

(multiplicand '(* 2 1 1 3 x 1 y 4))

(define (multiplicand e)
  (if (null? (cdddr e))
      (caddr e)
      (cons '* (cddr e))))

(multiplicand '(* 2 1 1 3 x 1 y 4))

(define (variable? e) (symbol? e))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

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
        (else
          (error "unknown experssion type -- DERIV" expr))))

(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)
(deriv '(* x y (+ x 3)) 'x)

