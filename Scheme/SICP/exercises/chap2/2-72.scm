;;;; Exercise 2.72

;;; Consider the encoding procedure that you designed in exercise 2.68.
;;; What is the order of growth in the number of steps needed to encode a
;;; symbol? Be sure to include the number of steps needed to search the
;;; symbol list at each node encountered. To answer this question in general
;;; is difficult. Consider the special case where the relative frequencies
;;; of the n symbols are as described in exercise 2.71, and give the order
;;; of growth (as a function of n) of the number of steps needed to encode
;;; the most frequent and least frequent symbols in the alphabet.

;;; Assume each branch of the tree has size (n / 2). We are going to encode
;;; an arbitrary symbol.
;;;
;;; Then let T(n) be the number of steps executed by encode-symbol with an
;;; input of size n.
;;;
;;;         a,                  if n = 1
;;; T(n) =
;;;         T(n / 2) + bn + c,  if n > 1
;;;
;;; By Master Theorem, T(n) ∈ O(n).
;;;
;;; In the special case described in exercise 2.71, the order of growth of
;;; the number of steps needed to encode the most frequent symbols is Θ(n),
;;; since we need to search through the whole set in the worst case;
;;; and that of the least frequent symbols is Θ(n^2), since in the worst
;;; case, we need to go through the whole set at each level; so in total is
;;; ((n - 1) + (n - 2) + ... + 2 + 1) = (n * (n - 1)) / 2).
