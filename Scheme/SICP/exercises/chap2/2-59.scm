;;;; Exercise 2.59

;;; Implement the union-set operation for the unordered-list representation
;;; of sets.

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else (cons (car set1)
                    (union-set (cdr set1) set2)))))

(union-set '() '())
(union-set (list 1 2) '())
(union-set '() (list 1 2))
(union-set (list 1 2 3 4 5) (list 3 4 5 6))
(union-set (list 1 2 3) (list 4 5 6))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (union-set (cdr set1)
                         (adjoin-set (car set1) set2)))))

(union-set '() '())
(union-set (list 1 2) '())
(union-set '() (list 1 2))
(union-set (list 1 2 3 4 5) (list 3 4 5 6))
(union-set (list 1 2 3) (list 4 5 6))

(define (union-set set1 set2)
  (fold-right cons set2 (filter (lambda (x)
                                  (not (element-of-set? x set2)))
                                set1)))

(union-set '() '())
(union-set (list 1 2) '())
(union-set '() (list 1 2))
(union-set (list 1 2 3 4 5) (list 3 4 5 6))
(union-set (list 1 2 3) (list 4 5 6))

(define (union-set set1 set2)
  (append set1 (filter (lambda (x) (not (element-of-set? x set1)))
                       set2)))

(union-set '() '())
(union-set (list 1 2) '())
(union-set '() (list 1 2))
(union-set (list 1 2 3 4 5) (list 3 4 5 6))
(union-set (list 1 2 3) (list 4 5 6))
