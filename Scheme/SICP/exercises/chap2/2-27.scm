;;;; Exercise 2.27

;;; Modify your reverse procedure of exercise 2.18 to produce a deep-reverse
;;; procedure that takes a list as argument and returns as its value the list
;;; with its elements reversed and with all sublists deep-reversed as well.
;;; For example,
;;;
;;; (define x (list (list 1 2) (list 3 4)))
;;;
;;; x
;;; ((1 2) (3 4))
;;;
;;; (reverse x)
;;; ((3 4) (1 2))
;;;
;;; (deep-reverse x)
;;; ((4 3) (2 1))

(define nil '())
(define x (list (list 1 2) (list 3 4) (list 5 6)))
x

;;; Iterative Process
(define (reverse l)
  (define (iter l r)
    (if (null? l)
        r
        (iter (cdr l) (cons (car l) r))))
  (iter l nil))

;;; Iterative Process
(define (deep-reverse l)
  (define (iter l r)
    (if (null? l)
        r
        (iter (cdr l) (cons (if (pair? (car l))
                                (deep-reverse (car l))
                                (car l))
                            r))))
  (iter l nil))

(reverse x)
(deep-reverse x)

;;; Recursive Process
(define (reverse l)
  (if (or (null? l) (null? (cdr l)))
      l
      (append (reverse (cdr l)) (list (car l)))))

;;; Recursive Process
(define (deep-reverse l)
  (define (helper l)
    (list (if (pair? l) (deep-reverse l) l)))
  (if (or (null? l) (null? (cdr l)))
      (helper (car l))
      (append (deep-reverse (cdr l))
              (helper (car l)))))

(reverse x)
(deep-reverse x)
