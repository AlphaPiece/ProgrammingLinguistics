;;;; Exercise 2.22

;;; Louis Reasoner tries to rewrite the first square-list procedure of
;;; exercise 2.21 so that it evolves an iterative process:

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))

;;; Unfortunately, defining square-list this way produces the answer
;;; list in the reverse order of the one desired. Why?

;;; The value of answer in the iteration:
;;;
;;; nil
;;; (cons first-item nil)
;;; (cons second-item (cons first-item nil))
;;; ...
;;;
;;; Return value:
;;;
;;; (last-item ... second-item first-item)

;;; Louis then tries to fix his bug by interchanging the arguments to cons:

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))

;;; This doesn’t work either. Explain.

;;; The value of answer in the iteration:
;;;
;;; nil
;;; (cons nil first-item)
;;; (cons (cons nil first-item) second-item)
;;; ...
;;;
;;; Return value:
;;;
;;; ((...((first-item) second-item)...) last-item)
