;;;; Exercise 1.37

;;; a. An infinite continued fraction is an expression of the
;;; form
;;;
;;;                 N_1
;;; f = ---------------------------
;;;                    N_2
;;;      D_1 + -------------------
;;;                       N_3
;;;             D_2 + -----------
;;;                    D_3 + ...
;;;
;;; As an example, one can show that the infinite continued
;;; fraction expansion with the N_i and the D_i all equal to
;;; 1 produces 1/ϕ , where ϕ is the golden ratio (described in
;;; section 1.2.2). One way to approximate an infinite continued
;;; fraction is to truncate the expansion after a given number
;;; of terms. Such a truncation -- a so-called k-term finite
;;; continued fraction -- has the form
;;;
;;;          N_1
;;; ---------------------
;;;             N_2
;;;  D_1 + -------------
;;;         .
;;;          .     N_k
;;;           . + -----
;;;                D_k
;;;
;;; 
;;; Suppose that n and d are procedures of one argument
;;; (the term index i) that return the N_i and D_i of the
;;; terms of the continued fraction. Define a procedure cont-frac
;;; such that evaluating (cont-frac n d k) computes the value of
;;; the k-term finite continued fraction. Check your procedure by
;;; approximating 1/ϕ using
;;;
;;; (cont-frac (lambda (i) 1.0)
;;;            (lambda (i) 1.0)
;;;            k)
;;;
;;; for successive values of k. How large must you make k in
;;; order to get an approximation that is accurate to 4 decimal
;;; places?
;;;
;;; b. If your cont-frac procedure generates a recursive process,
;;; write one that generates an iterative process. If it generates
;;; an iterative process, write one that generates a recursive
;;; process.

(define (cont-frac-recur n d k)
  (define (recur i)
    (if (= i k)
        (/ (n k) (d k))
        (/ (n i) (+ (d i)
                    (recur (+ i 1))))))
  (recur 1))

(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1)
              (/ (n i)
                 (+ (d i) result)))))
  (iter k 0))

(cont-frac-recur (lambda (i) 1.0)
                 (lambda (i) 1.0)
                 13)

(cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
                14)

;;; 8-terms:        0.6176470588235294 -> 0.6176
;;; 9-terms:        0.6181818181818182 -> 0.6182
;;; 10-terms:       0.6179775280898876 -> 0.6180
;;; 11-terms:       0.6180555555555556 -> 0.6181
;;; 12-terms:       0.6180257510729613 -> 0.6180
;;; 13-terms:       0.6180371352785146 -> 0.6180
;;; 14-terms:       0.6180327868852459 -> 0.6180
;;; 100-terms:      0.6180339887498948 -> 0.6180
;;;
;;; In order to get an approximation that is accurate to 4
;;; decimal places, we need to make k = 10 or k >= 12.
