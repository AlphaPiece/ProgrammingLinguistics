;;;; Exercise 2.35

;;; Redefine count-leaves from section 2.2.2 as an accumulation:

(define nil '())

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (count-leaves tree)
  (accumulate + 0 (map (lambda (leaf) 1)
                       (enumerate-tree tree))))

(define t (list 1 (list 2 (list 3 4)) 5))
(count-leaves t)

(define (count-leaves tree)
  (accumulate + 0 (map (lambda (sub-tree)
                         (if (pair? sub-tree)
                             (count-leaves sub-tree)
                             1))
                       tree)))

(count-leaves t)
