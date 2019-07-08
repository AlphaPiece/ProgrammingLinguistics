;;;; Notes for Section 2.2

;;;
;;; 2.2.1
;;;

(define l (list 1 2 3 4 5))
(car l)
(cdr l)
(cadr l)
(car (cddddr l))

(define one-through-four (list 1 2 3 4))
one-through-four
(car one-through-four)
(cdr one-through-four)
(car (cdr one-through-four))
(cons 10 one-through-four)
(cons 5 one-through-four)

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define squares (list 1 4 9 16 25))
(list-ref squares 3)

;;; Recursive Process
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(define odds (list 1 3 5 7))
(length odds)

;;; Iterative Process
(define (length items)
  (define (iter items count)
    (if (null? items)
        count
        (iter (cdr items) (+ count 1))))
  (iter items 0))

(length odds)

(define (copy l)
  (if (null? l)
      l
      (cons (car l) (copy (cdr l)))))

(define l1 (list 1 1 2 3 5 8 13))
l1
(define l2 (copy l1))
l2

(define (append l1 l2)
  (if (null? l1)
      (copy l2)
      (cons (car l1) (append (cdr l1) l2))))

(append l1 l2)
