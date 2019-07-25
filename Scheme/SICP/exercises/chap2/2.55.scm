;;;; Exercise 2.55

;;; Eva Lu Ator types to the interpreter the expression
;;;
;;; (car ''abracadabra)
;;;
;;; To her surprise, the interpreter prints back quote. Explain.

(define e1 ''abracadabra)
(define e2 (quote (quote abracadabra)))

e1
e2

(car e1)
(car e2)

(cdr e1)
(cdr e2)

;;; The first ' quotes the following 'abracadabra, so it becomes a list
;;; which contains two symbols: ' and abracadabra. So applying car on the
;;; list will yield quote, which is '.
