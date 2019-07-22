;;;; Exercise 2.41

;;; Write a procedure to find all ordered triples of distinct positive
;;; integers i, j, and k less than or equal to a given integer n that sum
;;; to a given integer s.

(define nil '())

(define (enumerate-interval low high)
  (define (iter interval n)
    (if (> n high)
        interval
        (iter (cons n interval) (+ n 1))))
  (iter nil low))

(define (flatmap proc seq)
  (fold-right append nil (map proc seq)))

(define (unique-triples n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k)
                               (list i j k))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(unique-triples 7)

(define (sum-triples n s)
  (filter (lambda (triple)
            (= (+ (car triple) (cadr triple) (caddr triple)) s))
          (unique-triples n)))

(sum-triples 7 14)
