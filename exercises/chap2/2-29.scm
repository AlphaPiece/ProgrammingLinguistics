;;;; Exercise 2.29

;;; A binary mobile consists of two branches, a left branch and a right
;;; branch. Each branch is a rod of a certain length, from which hangs
;;; either a weight or another binary mobile. We can represent a binary
;;; mobile using compound data by constructing it from two branches (for
;;; example, using list):

(define (make-mobile left right)
  (list left right))

;;; A branch is constructed from a length (which must be a number) together
;;; with a structure, which may be either a number (representing a simple
;;; weight) or another mobile:

(define (make-branch length structure)
  (list length structure))

(define b1 (make-branch 3 4))
(define b2 (make-branch 6 2))
(define m1 (make-mobile b1 b2))
(define b3 (make-branch 4 m1))
(define b4 (make-branch 8 3))
(define m2 (make-mobile b3 b4))

;;; a. Write the corresponding selectors left-branch and right-branch,
;;; which return the branches of a mobile, and branch-length and
;;; branch-structure, which return the components of a branch.

(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cadr mobile))

(left-branch m1)
(right-branch m2)

(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cadr branch))

(branch-length b1)
(branch-structure b3)

;;; b. Using your selectors, define a procedure total-weight that returns
;;; the total weight of a mobile.

(define (total-weight mobile)
  (if (not (pair? mobile))
      mobile
      (+ (total-weight (branch-structure (left-branch mobile)))
         (total-weight (branch-structure (right-branch mobile))))))

(total-weight m1)       ; 6
(total-weight m2)       ; 9

;;; c. A mobile is said to be balanced if the torque applied by its top-left
;;; branch is equal to that applied by its top-right branch (that is, if the
;;; length of the left rod multiplied by the weight hanging from that rod is
;;; equal to the corresponding product for the right side) and if each of the
;;; submobiles hanging off its branches is balanced. Design a predicate that
;;; tests whether a binary mobile is balanced.

(define (balanced? mobile)
  (if (not (pair? mobile))
      true
      (and (= (* (branch-length (left-branch mobile))
                 (total-weight (branch-structure (left-branch mobile))))
              (* (branch-length (right-branch mobile))
                 (total-weight (branch-structure (right-branch mobile)))))
           (balanced? (branch-structure (left-branch mobile)))
           (balanced? (branch-structure (right-branch mobile))))))

(balanced? m1)      ; #t
(balanced? m2)      ; #t

;;; d. Suppose we change the representation of mobiles so that the
;;; constructors are

(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))

;;; How much do you need to change your programs to convert to the new
;;; representation?

;;; I just need to change right-branch and branch-structure.

(define (right-branch mobile)
  (cdr mobile))

(define (branch-structure branch)
  (cdr branch))

(define b1 (make-branch 3 4))
(define b2 (make-branch 6 2))
(define m1 (make-mobile b1 b2))
(define b3 (make-branch 4 m1))
(define b4 (make-branch 8 3))
(define m2 (make-mobile b3 b4))

(total-weight m1)       ; 6
(total-weight m2)       ; 9

(balanced? m1)      ; #t
(balanced? m2)      ; #t

;;; Then I will get the same result as before.
