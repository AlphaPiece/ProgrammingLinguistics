;;;; Exercise 2.64

;;; The following procedure list->tree converts an ordered list to a
;;; balanced binary tree. The helper procedure partial-tree takes as
;;; arguments an integer n and list of at least n elements and constructs
;;; a balanced tree containing the first n elements of the list. The result
;;; returned by partial-tree is a pair (formed with cons) whose car is the
;;; constructed tree and whose cdr is the list of elements not included in
;;; the tree.

(define (list->tree elements)
  (car (partial-tree elements (length elements))))
(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

;;; a. Write a short paragraph explaining as clearly as you can how
;;; partial-tree works. Draw the tree produced by list->tree for the
;;; list (1 3 5 7 9 11).
;;;
;;; b. What is the order of growth in the number of steps required by
;;; list->tree to convert a list of n elements?

;;; a.
;;;
;;; If n = 0, then there is no element to be formed a tree. Thus, we
;;; simply return the pair ('() elts).
;;;
;;; If n > 0, then we halve n and recursively call partial-tree with
;;; the first half (left half) of elts and get the pair of left-tree
;;; and leftover elements in elts formed by that half, which is
;;; left-result.
;;; And then we extract the first element from the second half (right
;;; half) to be the entry, and recursively call partial-tree with
;;; the second half without the first element, and get the pair of
;;; right-tree and leftover elements in elts formed by that half,
;;; which is right-result.
;;; Finally, we use cons to make a pair of a tree formed by entry,
;;; left-tree, and right-tree and the remaining elements we get from
;;; right-result.
;;;
;;;        5
;;;      /   \
;;;    1       9
;;;     \     / \
;;;      3   7   11

;;; b.
;;;
;;; The order of growth in the number of steps required by list->tree
;;; is Θ(n).
