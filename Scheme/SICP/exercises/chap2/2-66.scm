;;;; Exercise 2.66

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

;;; Implement the lookup procedure for the case where the set of records
;;; is structured as a binary tree, ordered by the numerical values of the
;;; keys.

(define (key record) (car record))

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((> given-key (key (entry set-of-records)))
         (lookup given-key (right-branch set-of-records)))
        ((< given-key (key (entry set-of-records)))
         (lookup given-key (left-branch set-of-records)))
        (else (entry set-of-records))))

(define set-of-records
  (make-tree (list 21 "Walker")
             (make-tree (list 9 "Noah")
                        (make-tree (list 4 "Riche") '() '())
                        '())
             (make-tree (list 25 "Adam")
                        '()
                        (make-tree (list 33 "Jane")
                                   (make-tree (list 27 "Susan") '() '())
                                   '()))))

set-of-records
(lookup 21 set-of-records)
(lookup 27 set-of-records)
