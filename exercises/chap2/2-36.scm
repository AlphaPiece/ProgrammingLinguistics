;;;; Exercise 2.36

;;; The procedure accumulate-n is similar to accumulate except that it takes
;;; as its third argument a sequence of sequences, which are all assumed to
;;; have the same number of elements. It applies the designated accumulation
;;; procedure to combine all the first elements of the sequences, all the
;;; second elements of the sequences, and so on, and returns a sequence of
;;; the results. For instance, if s is a sequence containing four sequences,
;;; ((1 2 3) (4 5 6) (7 8 9) (10 11 12)), then the value of (accumulate-n + 0 s)
;;; should be the sequence (22 26 30). Fill in the missing expressions in the
;;; following definition of accumulate-n:
;;;
;;; (define (accumulate-n op init seqs)
;;;   (if (null? (car seqs))
;;;       nil
;;;       (cons (accumulate op init <??>)
;;;             (accumulate-n op init <??>))))

(define s (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))

(define nil '())

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (enumerate-first seqs)
  (map (lambda (seq) (car seq)) seqs))

(enumerate-first s)

(define (enumerate-rest seqs)
  (map (lambda (seq) (cdr seq)) seqs))

(enumerate-rest s)

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (enumerate-first seqs))
            (accumulate-n op init (enumerate-rest seqs)))))

(accumulate-n + 0 s)

;;; Alternative

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define (enumerate-list-ref n seqs)
  (if (null? seqs)
      nil
      (cons (list-ref (car seqs) n)
            (enumerate-list-ref n (cdr seqs)))))

(enumerate-list-ref 0 s)
(enumerate-list-ref 2 s)

(define (accumulate-n op init seqs)
  (let ((n (length (car seqs))))
    (define (recur i)
      (if (= i n)
          nil
          (cons (accumulate op init (enumerate-list-ref i seqs))
                (recur (+ i 1)))))
    (recur 0)))

(accumulate-n + 0 s)

