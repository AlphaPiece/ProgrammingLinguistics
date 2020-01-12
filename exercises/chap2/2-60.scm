;;;; Exercise 2.60

;;; We specified that a set would be represented as a list with no
;;; duplicates. Now suppose we allow duplicates. For instance, the set
;;; {1,2,3} could be represented as the list (2 3 2 1 3 2 2). Design
;;; procedures element-of-set?, adjoin-set, union-set, and intersection-set
;;; that operate on this representation. How does the efficiency of each
;;; compare with the corresponding procedure for the non-duplicate
;;; representation? Are there applications for which you would use this
;;; representation in preference to the non-duplicate one?

;;; Let n be the size of set.
 
;;; non-duplicate:  Θ(n) steps
;;; duplicate:      Θ(n) steps
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

;;; non-duplicate:  Θ(n) steps
;;; duplicate:      Θ(1) steps
(define (adjoin-set x set)
  (cons x set))

;;; non-duplicate:  Θ(n) steps
(define (remove-set x set)
  (cond ((null? set) '())
        ((equal? (car set) x) (cdr set))
        (else (cons (car set)
                    (remove-set x (cdr set))))))

(remove-set 3 (list 1 2 3 4 5))

;;; duplicate:      Θ(n) steps
(define (remove-set x set)
  (cond ((null? set) '())
        ((equal? (car set) x)
         (remove-set x (cdr set)))
        (else (cons (car set)
                    (remove-set x (cdr set))))))

(remove-set 3 (list 1 2 3 4 2 3 5))

;;; Assume that both set1 and set2 have the same size n.

;;; non-duplicate:  Θ(n^2) steps
;;; duplicate:      Θ(n) steps
(define (union-set set1 set2)
  (append set1 set2))

;;; non-duplicate:  Θ(n^2) steps
;;; duplicate:      Θ(n^2) steps
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (remove-set (car set1) set1)
                                 set2)))
        (else (intersection-set (cdr set1) set2))))

(intersection-set (list 1 2 3) (list 2 3 4))

;;; If a program needed to use adjoin-set and union-set much more
;;; frequently than to use remove-set and intersection-set, then
;;; using duplicate representation would save a lot of computation steps.
