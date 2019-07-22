;;;; Exercise 2.40

;;; Define a procedure unique-pairs that, given an integer n, generates the
;;; sequence of pairs (i, j) with 1 <= j < i <= n. Use unique-pairs to simplify
;;; the definition of prime-sum-pairs given above.

(define nil '())

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(enumerate-interval 1 10)

(define (flatmap proc seq)
  (fold-right append nil (map proc seq)))

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(unique-pairs 5)

(define (prime? n)
  (define (iter i)
    (cond ((> (square i) n) true)
          ((= (remainder n i) 0) false)
          (else (iter (+ i 1)))))
  (if (< n 2)
      false
      (iter 2)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))

(prime-sum-pairs 6)
