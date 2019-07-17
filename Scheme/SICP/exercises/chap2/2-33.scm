;;;; Exercise 2.33

;;; Fill in the missing expressions to complete the following definitions of
;;; some basic list-manipulation operations as accumulations:

(define nil '())

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define seq1 (list 1 2 3 4 5))
(define seq2 (list 6 7 8 9 10))

(define (map p seq)
  (accumulate (lambda (x y) (cons (p x) y)) nil seq))

(map square seq1)
(map square seq2)

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(append seq1 seq2)
(append seq2 seq1)

(define (length seq)
  (accumulate (lambda (x y) (+ 1 y)) 0 seq))

(length seq1)
(length seq2)
