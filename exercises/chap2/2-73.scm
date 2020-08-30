;;;; Exercise 2.73

;;; Section 2.3.2 described a program that performs symbolic differentiation:

(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr) (if (same-variable? expr var) 1 0))
        ((sum? expr)
         (make-sum (deriv (addend expr) var)
                   (deriv (augend expr) var)))
        ((product? expr)
         (make-sum
           (make-product (multiplier expr)
                         (deriv (multiplicand expr) var))
           (make-product (deriv (multiplier expr) var)
                         (multiplicand expr))))
        ;; <more rules can be added here>
        (else (error "unknown exprression type -- DERIV" expr))))

;;; We can regard this program as performing a dispatch on the type of the
;;; exprression to be differentiated. In this situation the "type tag" of the
;;; datum is the algebraic operator symbol (such as +) and the operation being
;;; performed is deriv. We can transform this program into data-directed
;;; style by rewriting the basic derivative procedure as

(define (deriv expr var)
   (cond ((number? expr) 0)
         ((variable? expr) (if (same-variable? expr var) 1 0))
         (else ((get 'deriv (operator expr)) (operands expr)
                                            var))))
(define (operator expr) (car expr))
(define (operands expr) (cdr expr))

;;; a. Explain what was done above. Why can’t we assimilate the predicates
;;; number? and same-variable? into the data-directed dispatch?

;;; Answer:
;;; Because they are predicates, we do not need multiple procedures for that.

;;; b. Write the procedures for derivatives of sums and products, and the
;;; auxiliary code required to install them in the table used by the program
;;; above.

(define (install-deriv-sum-package)
  ;; Internal procedures
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  (define (make-sum a1 a2)
    (cond ((eq? a1 0) a2)
          ((eq? a2 0) a1)
          ((and (number? a1) (number? a2))
           (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (deriv-sum expr var)
    (make-sum (deriv (addend expr) var)
              (deriv (augend expr) var)))
  ;; Interface to the rest of the system
  (put 'deriv '+ deriv-sum)
  'done)

(define (install-deriv-product-package)
  ;; Internal procedures
  (define (multiplier p) (car p))
  (define (multiplicant p) (cadr p))
  (define (make-product m1 m2)
    (cond ((eq? m1 1) m2)
          ((eq? m2 1) m1)
          ((and (number? m1) (number? m2))
           (* m1 m2))
          (else (list '* m1 m2))))
  (define (deriv-product expr var)
    (make-sum
      (make-product (multiplier expr)
                    (deriv (multiplicand expr) var))
      (make-product (deriv (multiplier expr) var)
                    (multiplicand expr))))
  ;; Interface to the rest of the system
  (put 'deriv '* deriv-product)
  'done)

;;; c. Choose any additional differentiation rule that you like, such as the
;;; one for expronents (exercise 2.56), and install it in this data-directed
;;; system.

(define (install-deriv-product-package)
  ;; Internal procedures
  (define (base e) (car e))
  (define (exponent e) (cadr e))
  (define (make-exponentiation b e)
    (cond ((or (eq? b 1) (eq? e 0)) 1)
          ((eq? e 1) b)
          ((and (number? b) (number? e))
           (expt b e))
          (else (list '** b e))))
  (define (deriv-exponentiation expr var)
    (make-product
      (make-product (exponent expr)
                    (make-exponentiation (base expr)
                                         (make-sum (exponent expr)
                                                   -1)))
      (deriv (base expr) var)))
  ;; Interface to the rest of the system
  (put 'deriv '** deriv-exponentiation)
  'done)

;;; d. In this simple algebraic manipulator the type of an exprression is the
;;; algebraic operator that binds it together. Suppose, however, we indexed
;;; the procedures in the opposite way, so that the dispatch line in deriv
;;; looked like
;;;
;;; ((get (operator expr) 'deriv) (operands expr) var)
;;;
;;; What corresponding changes to the derivative system are required?

;;; Answer:
;;; We only need to change the interface of each package. In particular,
;;; change the order of arguments of the put procedure call.
