;;;; Exercise 2.54

;;; Two lists are said to be equal? if they contain equal elements arranged
;;; in the same order. For example,
;;;
;;; (equal? '(this is a list) '(this is a list))
;;;
;;; is true, but
;;;
;;; (equal? '(this is a list) '(this (is a) list))
;;;
;;; is false. To be more precise, we can define equal? recursively in terms
;;; of the basic eq? equality of symbols by saying that a and b are equal?
;;; if they are both symbols and the symbols are eq?, or if they are both
;;; lists such that (car a) is equal? to (car b) and (cdr a) is equal? to
;;; (cdr b). Using this idea, implement equal? as a procedure.

(define (equal? a b)
  (cond ((and (number? a) (number? b))
         (= a b))
        ((and (not (pair? a)) (not (pair? b)))
         (eq? a b))
        ((and (pair? a) (pair? b))
         (and (equal? (car a) (car b))
              (equal? (cdr a) (cdr b))))
        (else false)))

;;; #t
(equal? '(this is a list) '(this is a list))

;;; #f
(equal? '(this is a list) '(this (is a) list))

;;; #t
(equal? '(a b (c (d e)) f) '(a b (c (d e)) f))

;;; #f
(equal? '(a b (c (d e)) f) '(a b (c (d d)) f))

;;; #t
(equal? 3 3)

;;; #t
(equal? 3 3.0)

;;; #t or #f depending on the implementation
(equal? 3.0 3.0)

;;; #f
(equal? (cons 'a 'b) (cons 'a 'c))

;;; #t
(equal? (cons 'a 'b) (cons 'a 'b))
