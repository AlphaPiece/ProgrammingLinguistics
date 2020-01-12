;;;; Exercise 2.71

;;; Suppose we have a Huffman tree for an alphabet of n symbols, and that the
;;; relative frequencies of the symbols are 1, 2, 4, ..., 2^(n-1). Sketch the
;;; tree for n = 5; for n = 10. In such a tree (for general n) how may bits are
;;; required to encode the most frequent symbol? the least frequent symbol?

;;; For n = 5:
;;;     Frequency:  {16, 8,  4,   2,    1}
;;;     Bits:       {0,  10, 110, 1110, 1111}
;;;     Length:     {1,  2,  3,   4,    4}
;;;
;;; The most ferquent symbol needs 1 bits;
;;; the least frequent symbol needs (n - 1) bits.
