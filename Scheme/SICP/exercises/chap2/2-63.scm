;;;; Exercise 2.63

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

;;; Each of the following two procedures converts a binary tree to a list.

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;;; a. Do the two procedures produce the same result for every tree? If not,
;;; how do the results differ? What lists do the two procedures produce for
;;; the trees in figure 2.16?
;;;
;;; b. Do the two procedures have the same order of growth in the number
;;; of steps required to convert a balanced tree with n elements to a list?
;;; If not, which one grows more slowly?

(define tree (make-tree 3
                        (make-tree 1 '() (make-tree 2 '() '()))
                        (make-tree 4 '() '())))

(tree->list-1 tree)
(tree->list-2 tree)

(define tree (make-tree 1 '() (make-tree 2 '() (make-tree 3 '() '()))))

(tree->list-1 tree)
(tree->list-2 tree)

(define tree (make-tree 7
                        (make-tree 3
                                   (make-tree 1 '() '())
                                   (make-tree 5 '() '()))
                        (make-tree 9
                                   '()
                                   (make-tree 11 '() '()))))

(tree->list-1 tree)
(tree->list-2 tree)

(define tree (make-tree 3
                        (make-tree 1 '() '())
                        (make-tree 7
                                   (make-tree 5 '() '())
                                   (make-tree 9
                                              '()
                                              (make-tree 11 '() '())))))

(tree->list-1 tree)
(tree->list-2 tree)

(define tree (make-tree 5
                        (make-tree 3
                                   (make-tree 1 '() '())
                                   '())
                        (make-tree 9
                                   (make-tree 7 '() '())
                                   (make-tree 11 '() '()))))

(tree->list-1 tree)
(tree->list-2 tree)

;;; a.
;;;
;;; Yes, the two procedures product the same result for every tree. The
;;; lists the two procedures produce are always sorted.
;;; Both procedures will produce (1 3 5 7 9 11) for all the trees in
;;; figure 2.16.

;;; b.
;;;
;;; No, tree->list-1 has Θ(nlogn) and tree->list-2 has Θ(n), assuming
;;; append has Θ(n) and cons has Θ(1).
;;;
;;; Let n be the number of nodes in tree. Let a, b, and c be some constants.
;;;
;;; Let T_1 be the runtime of tree->list-1 with input of size n.
;;;
;;;           a,                        if n = 1
;;; T_1(n) = 
;;;           2T_1(n/2) + (1/2)bn + c,  if n > 1
;;;
;;; Let T_2 be the runtime of tree->list-1 with input of size n.
;;;
;;;           a,                if n = 1
;;; T_2(n) =
;;;           2T_2(n/2) + c,    if n > 1
;;;
;;; By using substitution method, we can obtain a closed form of T_1(n):
;;;
;;; an + (1/2)bnlog_2(n) + (n - 1),
;;;
;;; and a closed form of T_2(n):
;;;
;;; an + (n - 1).
;;;
;;; Thus, T_1(n) ∈ Θ(nlogn) and T_2(n) ∈ Θ(n).
