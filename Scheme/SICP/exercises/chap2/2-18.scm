;;;; Exercise 2.18

;;; Define a procedure reverse that takes a list as argument and returns
;;; a list of the same elements in reverse order:
;;;
;;; (reverse (list 1 4 9 16 25))
;;; (25 16 9 4 1)

(define nil '())

;;; Iterative Process
(define (reverse l)
  (define (iter l r)
    (if (null? l)
        r
        (iter (cdr l) (cons (car l) r))))
  (iter l nil))

(reverse (list 1 4 9 16 25))

;;; Recursive Process
(define (reverse l)
  (if (or (null? l) (null? (cdr l)))
      l
      (append (reverse (cdr l)) (list (car l)))))

(reverse (list 1 4 9 16 25))
