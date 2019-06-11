;;; Louis Reasoner is having great difficulty doing exercise 1.24. His
;;; fast-prime? test seems to run more slowly than his prime? test. Louis
;;; calls his friend Eva Lu Ator over to help. When they examine Louis’s code,
;;; they find that he has rewritten the expmod procedure to use an explicit
;;; multiplication, rather than calling square:

(define (expmod b n m)
  (cond ((= n 0) 1)
        ((even? n)
         (remainder (* (expmod b (/ n 2) m)
                       (expmod b (/ n 2) m))
                    m))
        (else
         (remainder (* b (expmod b (- n 1) m))
                    m))))

;;; "I don't see what difference that could make," says Louis.
;;; "I do." says Eva. "By writing the procedure like that, you have
;;; transformed the Θ(log(n)) process into a Θ(n) process." Explain.

;;; Let T(n) be the number of step cost by expmod with an input of size n
;;; for n. (Since b and m will never change, we will ignore it in the analysis.)
;;;
;;; Let a, b, c be real constants.
;;;
;;;        a,                 if n = 0
;;; T(n) = 2 * T(n / 2) + b,  if n > 0 and n % 2 = 0
;;;        T(n - 1) + c,      if n > 0 and n % 2 = 1
;;;
;;; In asymptotic analysis, we may always assume that the size of the input is
;;; so that the recursive calls always divide the input list evenly.
;;;
;;; Assume n > 0 and n is a power of 2, i.e., there exists a positive number i
;;; such that 2^i = n <=> i = log_2(n) (*).
;;; 
;;; Also note that sum(r^t, t = 0, m - 1) = (r^m - 1) / (r - 1) (**).
;;;
;;;   T(n)
;;;
;;; = 2 * T(n / 2) + b
;;;
;;; = 2 * (2 * T(n / 2^2) + b) + b
;;; = 2^2 * T(n / 2^2) + (2 + 1) * b
;;;
;;; = 2^2 * (2 * T(n / 2^3) + b) + (2 + 1) * b
;;; = 2^3 * T(n / 2^3) + (2^2 + 2 + 1) * b
;;;
;;; ...
;;;
;;; = 2^i * T(n / 2^i) + (2^(i - 1) + ... + 2 + 1) * b        [by (*)]
;;; = n * T(n / n) + (sum(2^j, j = 0, log_2(n) - 1)) * b      [by (**)]
;;; = n * T(1) + ((2^log_2(n) - 1) / (2 - 1)) * b
;;; = n * a + (n - 1) * b
;;; = (a + b) * n - b
;;;
;;; Thus T(n) = (a + b) * n - b and T(n) in Θ(n).
