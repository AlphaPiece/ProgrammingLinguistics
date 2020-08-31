;;;; Exercise 2.76

;;; As a large system with generic operations evolves, new types of data
;;; objects or new operations may be needed. For each of the three
;;; strategies -- generic operations with explicit dispatch,
;;; data-directed style, and message-passing-style -- describe the
;;; changes that must be made to a system in order to add new types or
;;; new operations. Which organization would be most appropriate for
;;; a system in which new types must often be added? Which would be most
;;; appropriate for a system in which new operations must often be added?

;;; Answer:

;;; Generic operations with explicit dispatch:

(define (real-part z)
  (cond ((rectangular? z)
         (real-part-rectangular (contents z)))
        ((polar? z)
         (real-part-polar (contents z)))
        (else (error "Unknown type -- REAL-PART" z))))
(define (imag-part z)
  (cond ((rectangular? z)
         (imag-part-rectangular (contents z)))
        ((polar? z)
         (imag-part-polar (contents z)))
        (else (error "Unknown type -- IMAG-PART" z))))
(define (magnitude z)
  (cond ((rectangular? z)
         (magnitude-rectangular (contents z)))
        ((polar? z)
         (magnitude-polar (contents z)))
        (else (error "Unknown type -- MAGNITUDE" z))))
(define (angle z)
  (cond ((rectangular? z)
         (angle-rectangular (contents z)))
        ((polar? z)
         (angle-polar (contents z)))
        (else (error "Unknown type -- ANGLE" z))))

;;; Adding new operations does not require changing the existing code;
;;; adding new types requires changing every single existing operation
;;; procedure.

;;;
;;;

;;; Data-directed style:

(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

;;; Adding new operations does not require changing the existing code, just
;;; add another package; adding new types does require changing the existing
;;; code, but here we just need to change package (add new procedures and
;;; put new item into dispatch table).

;;;
;;;

;;; Message-passing style

(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude)
           (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)

;;; Adding new operations requires changing the existing code; adding
;;; new types, however, just add another constructor (dispatcher) like
;;; above.

;;; Message-passing style would be the most appropriate organization for
;;; a system in which new types must often be added. Data-direct style
;;; would be the most appropriate for a system in which new operations
;;; must often be added.
