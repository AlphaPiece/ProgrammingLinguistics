;;;; Exercise 1.6

;;; Why does 'if' need to be provided as a special form? Why can't we just
;;; define it as an ordinary procedure in terms of 'cond'?

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5)
(new-if (= 1 1) 0 5)

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

;;; 'new-if' doesn't work like the special form 'if' in sqrt-iter.
;;;
;;; Since new-if is a procedure, it is applicative-order evaluation.
;;; So it will evaluate both arguments before executing the procedure.
;;; Therefore, the else-clause is always evaluted and the interpreter
;;; will call sqrt-iter ad infinitum.
;;;
;;; The 'if' statement is a special form and behaves differently.
;;; 'if' first evalutes the predicate, and then evaluates either
;;; the consequent (if the predicate evaluates to #t) or the alternative
;;; (if the predicate evaluates to #f). This is key difference from
;;; 'new-if' -- only one of the two consequent expressions get evaluated
;;; when using if, while both of the consequent expressions get evalutated
;;; with new-if.
