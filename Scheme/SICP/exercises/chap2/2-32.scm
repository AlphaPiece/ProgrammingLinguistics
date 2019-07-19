;;;; Exercise 2.32

;;; We can represent a set as a list of distinct elements, and we can
;;; represent the set of all subsets of the set as a list of lists. For
;;; example, if the set is (1 2 3), then the set of all subsets is
;;; (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)). Complete the following
;;; definition of a procedure that generates the set of subsets of a set
;;; and give a clear explanation of why it works:
;;;
;;; (define (subsets s)
;;;   (if (null? s)
;;;       (list nil)
;;;       (let ((rest (subsets (cdr s))))
;;;         (append rest (map <??> rest)))))

(define nil '())

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (subset)
                            (cons (car s) subset))
                          rest)))))

(subsets (list 1 2 3))

;;; Explanation:
;;; 
;;; The mechanism behind subsets is that we seperate the set of subsets
;;; into two parts: subsets which contain the first element, and subsets
;;; which do not.
;;;
;;; We give the work of figuring out the second kind of subsets to
;;; (subsets (cdr s)) and assign the result to the temporary variable
;;; rest. And then we figure out the first kind of subsets by adding the
;;; first element to each subset in the set of second kind of subsets by
;;; using map, and finally append the set of first kind of subsets to the
;;; end of the set of second kind of subsets to obtain the final result.
;;;
;;; (subsets nil) -> (())
;;;
;;; (subsets (list 3)) -> (()) + ((3)) -> (() (3))
;;;
;;; (subsets (list 2 3)) -> (() (3)) + ((2) (2 3)) -> (() (3) (2) (2 3))
;;;
;;; (subsets (list 1 2 3)) -> (() (3) (2) (2 3)) + ((1) (1 3) (1 2) (1 2 3))
;;; -> (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
