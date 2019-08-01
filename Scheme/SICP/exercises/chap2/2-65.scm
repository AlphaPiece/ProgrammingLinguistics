;;;; Exercise 2.65

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

;;; Use the results of exercises 2.63 and 2.64 to give Θ(n) implementations
;;; of union-set and intersection-set for sets implemented as (balanced)
;;; binary trees.

;;; Θ(n) steps
(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;;; Θ(n) steps
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

;;; Sets as ordered lists
;;; Θ(n) steps
(define (union-set-ordered-list set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
          (let ((x1 (car set1)) (x2 (car set2)))
            (cond ((= x1 x2)
                   (cons x1 (union-set-ordered-list (cdr set1)
                                                    (cdr set2))))
                  ((< x1 x2)
                   (cons x1 (union-set-ordered-list (cdr set1)
                                                    set2)))
                  ((> x1 x2)
                   (cons x2 (union-set-ordered-list set1
                                                    (cdr set2)))))))))

;;; Θ(n) steps
(define (intersection-set-ordered-list set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-set-ordered-list (cdr set1)
                                                    (cdr set2))))
              ((< x1 x2)
               (intersection-set-ordered-list (cdr set1)
                                              set2))
              ((> x1 x2)
               (intersection-set-ordered-list set1
                                              (cdr set2)))))))

;;; Sets as balanced binary trees

;;; Θ(n) steps
(define (union-set set1 set2)
  (let ((list1 (tree->list set1))
        (list2 (tree->list set2)))
    (let ((result-list (union-set-ordered-list list1 list2)))
      (list->tree result-list))))

;;; Θ(n) steps
(define (intersection-set set1 set2)
  (let ((list1 (tree->list set1))
        (list2 (tree->list set2)))
    (let ((result-list (intersection-set-ordered-list list1 list2)))
      (list->tree result-list))))


(define tree1 (list->tree (list 1 2 3 4 5)))
(define tree2 (list->tree (list 3 4 5 6 7)))

(define union-tree (union-set tree1 tree2))
union-tree
(tree->list union-tree)

(define intersection-tree (intersection-set tree1 tree2))
intersection-tree
(tree->list intersection-tree)
