;;;; Exercise 2.68

(define (element-of-set x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set x (cdr set)))))

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf leaf) (cadr leaf))
(define (weight-leaf leaf) (caddr leaf))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
                (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree (make-leaf 'D 1)
                                    (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;;; The encode procedure takes as arguments a message and a tree and produces
;;; the list of bits that gives the encoded message.

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

;;; Encode-symbol is a procedure, which you must write, that returns the list
;;; of bits that encodes a given symbol according to a given tree. You should
;;; designencode-symbolso that it signals an error if the symbol is not in the
;;; tree at all. Test your procedure by encoding the result you obtained in
;;; exercise 2.67 with the sample tree and seeing whether it is the same as
;;; the original sample message.

(define (encode-symbol symbol tree)
  (define (collect-bits bits branch)
    (cond ((leaf? branch) bits)
          ((element-of-set symbol (symbols (left-branch branch)))
           (collect-bits (cons 0 bits) (left-branch branch)))
          ((element-of-set symbol (symbols (right-branch branch)))
           (collect-bits (cons 1 bits) (right-branch branch)))
          (else (error "bad symbol -- ENCODE-SYMBOL" symbol))))
  (reverse (collect-bits '() tree)))
        
(encode-symbol 'C sample-tree)
(encode-symbol 'B sample-tree)
(encode-symbol 'E sample-tree)

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((element-of-set symbol (symbols (left-branch tree)))
         (cons 0 (encode-symbol symbol (left-branch tree))))
        ((element-of-set symbol (symbols (right-branch tree)))
         (cons 1 (encode-symbol symbol (right-branch tree))))
        (else (error "bad symbol -- ENCODE-SYMBOL" symbol))))

(encode-symbol 'C sample-tree)
(encode-symbol 'B sample-tree)
(encode-symbol 'E sample-tree)
