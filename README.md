# Structure and Interpretation of Computer Programs (SICP)

This repository contains allthe exercises I did from SICP.

Scheme's syntax is extremely simple and clean. That means you can grasp the language real quick and just focus on the concepts that SICP tries to teach.

Fibonacci Series Example

```
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
```

Greatest Common Divisor Example
```
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
```

**Why Structure and Interpretation of Computer Programs matters**:

https://people.eecs.berkeley.edu/~bh/sicp.html

**SICP Free Text Online (MIT Press)**

https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-4.html#%_toc_start

**SICP Community Solutions**

http://community.schemewiki.org/?SICP-Solutions


![SICP Cover](https://user-images.githubusercontent.com/30487160/72214368-5ad46e00-34ce-11ea-844b-0e44bbbeacc7.jpg)
