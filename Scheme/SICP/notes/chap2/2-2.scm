;;;; Notes for Section 2.2

;;;
;;; 2.2.1
;;;

(define l (list 1 2 3 4 5))
(car l)
(cdr l)
(cadr l)
(car (cddddr l))

(define one-through-four (list 1 2 3 4))
one-through-four
(car one-through-four)
(cdr one-through-four)
(car (cdr one-through-four))
(cons 10 one-through-four)
(cons 5 one-through-four)

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define squares (list 1 4 9 16 25))
(list-ref squares 3)

;;; Recursive Process
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(define odds (list 1 3 5 7))
(length odds)

;;; Iterative Process
(define (length items)
  (define (iter items count)
    (if (null? items)
        count
        (iter (cdr items) (+ count 1))))
  (iter items 0))

(length odds)

(define (copy l)
  (if (null? l)
      l
      (cons (car l) (copy (cdr l)))))

(define l1 (list 1 1 2 3 5 8 13))
l1
(define l2 (copy l1))
l2

(define (append l1 l2)
  (if (null? l1)
      (copy l2)
      (cons (car l1) (append (cdr l1) l2))))

(append l1 l2)

(define nil '())

(define (scale-list items factor)
  (if (null? items)
      nil
      (cons (* (car items) factor)
            (scale-list (cdr items) factor))))

(scale-list (list 1 2 3 4 5) 10)

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(map abs (list -10 2.5 -11.6 17))
(map (lambda (x) (* x x))
     (list 1 2 3 4))

(define (scale-list items factor)
  (map (lambda (x) (* x factor))
       items))

(scale-list (list 1 2 3 4 5) 10)

;;;
;;; 2.2.2
;;;

(define (length items)
  (define (iter items count)
    (newline)
    (display items)
    (if (null? items)
        count
        (iter (cdr items) (+ count 1))))
  (iter items 0))

(define (count-leaves items)
  (cond ((null? items) 0)
        ((not (pair? items)) 1)
        (else (+ (count-leaves (car items))
              (count-leaves (cdr items))))))

(define x (cons (list 1 2) (list 3 4)))
(length x)
(count-leaves x)

(define y (list x x))
(length y)
(count-leaves y)

(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))

(scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7))
            10)

(define (scale-tree tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree sub-tree factor)
             (* sub-tree factor)))
       tree))

(scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7))
            10)
