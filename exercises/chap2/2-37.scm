;;;; Exercise 2.37

(define nil '())

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-first seqs)
  (map (lambda (seq) (car seq)) seqs))
(define (enumerate-rest seqs)
  (map (lambda (seq) (cdr seq)) seqs))
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (enumerate-first seqs))
            (accumulate-n op init (enumerate-rest seqs)))))

;;; Suppose we represent vectors v = (v_i) as sequences of numbers, and
;;; matrices m = (m_ij) as sequences of vectors (the rows of the matrix).
;;; For example, the matrix
;;;
;;; | 1 2 3 4 |
;;; | 4 5 6 6 |
;;; | 6 7 8 9 |
;;;
;;; is represented as the sequence ((1 2 3 4) (4 5 6 6) (6 7 8 9)). With
;;; this representation, we can use sequence operations to concisely express
;;; the basic matrix and vector operations. These operations (which are
;;; described in any book on matrix algebra) are the following:
;;;
;;; (dot-product v w)       returns the sum Σ_i(v_i * w_i);
;;; (matrix-*-vector m v)   returns the vector t, where t_i = Σ_j(m_ij * v_j);
;;; (matric-*-matrix m n)   returns the matrix p, where p_ij = Σ_k(m_ik * n_kj);
;;; (trasnpose m)           returns the matrix n, where n_ij = m_ji.
;;;
;;; We can define the dot product as

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

;;; Fill in the missing expressions in the following procedures for computing
;;; the other matrix operations. (The procedure accumulate-n is defined in
;;; exercise 2.36.)
;;;
;;; (define (matrix-*-vector m v)
;;;   (map <??> m))
;;;
;;; (define (transpose mat)
;;;   (accumulate-n <??> <??> mat))
;;;
;;; (define (matrix-*-matrix m n)
;;;   (let ((cols (transpose n)))
;;;     (map <??> m)))

(define m (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
(define v (list 1 2 3 4))

(define (matrix-*-vector m v)
  (map (lambda (r) (dot-product r v)) m))

(matrix-*-vector m v)

(define (transpose m)
  (accumulate-n cons nil m))

(transpose m)

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row))
         m)))

(matrix-*-matrix m (transpose m))
(define n (list (list 3 4 5) (list 1 4 2) (list 8 2 1) (list 4 5 8)))
(matrix-*-matrix m n)
(matrix-*-matrix n m)
