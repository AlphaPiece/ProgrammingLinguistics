;;;; Exercise 2.70

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

(define (element-of-set x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set x (cdr set)))))
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

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (if (<= (length leaf-set) 1)
      (car leaf-set)
      (successive-merge (adjoin-set (make-code-tree (car leaf-set)
                                                    (cadr leaf-set))
                                    (cddr leaf-set)))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((element-of-set symbol (symbols (left-branch tree)))
         (cons 0 (encode-symbol symbol (left-branch tree))))
        ((element-of-set symbol (symbols (right-branch tree)))
         (cons 1 (encode-symbol symbol (right-branch tree))))
        (else (error "bad symbol -- ENCODE-SYMBOL" symbol))))

;;; The following eight-symbol alphabet with associated relative frequencies
;;; was designed to efficiently encode the lyrics of 1950s rock songs.
;;; (Note that the ‘‘symbols’’ of an ‘‘alphabet’’ need not be individual
;;; letters.)
;;;
;;; A 2
;;; NA 16
;;; BOOM 1
;;; SHA 3
;;; GET 2
;;; YIP 9
;;; JOB 2
;;; WAH 1
;;;
;;; Use generate-huffman-tree (exercise 2.69) to generate a corresponding
;;; Huffman tree, and use encode (exercise 2.68) to encode the following
;;; message:
;;;
;;; Get a job
;;; Sha na na na na na na na na
;;; Get a job
;;; Sha na na na na na na na na
;;; Wah yip yip yip yip yip yip yip yip yip
;;; Sha boom
;;;
;;; How many bits are required for the encoding? What is the smallest number
;;; of bits that would be needed to encode this song if we used a fixed-length
;;; code for the eight-symbol alphabet?

(define pairs (list (list 'a 2)
                    (list 'na 16)
                    (list 'boom 1)
                    (list 'sha 3)
                    (list 'get 2)
                    (list 'yip 9)
                    (list 'job 2)
                    (list 'wah 1)))

(length pairs)

(define message (list 'get 'a 'job
                      'sha 'na 'na 'na 'na 'na 'na 'na 'na
                      'get 'a 'job
                      'sha 'na 'na 'na 'na 'na 'na 'na 'na
                      'wah 'yip 'yip 'yip 'yip 'yip 'yip 'yip 'yip 'yip
                      'sha 'boom))

(length message)

(define tree (generate-huffman-tree pairs))
(define bits (encode message tree))
(length bits)

;;; 84 bits are required for the encoding.
;;;
;;; Since there are 8 symbols in the alphabet, the smallest fixed-length
;;; code we can use is of length 3 (2^3 = 8). Then since there are 36 symbols
;;; in the message, the smallest number of bits that would be needed to
;;; encode is 36 * 3 = 108.
