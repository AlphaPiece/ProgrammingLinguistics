# Structure and Interpretation of Computer Programs (SICP)

This repository contains allthe exercises I did from SICP.

Scheme's syntax is extremely simple and clean. Take a look at the Fibonacci example below:
```
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
```

![SICP Cover](https://user-images.githubusercontent.com/30487160/72214368-5ad46e00-34ce-11ea-844b-0e44bbbeacc7.jpg)

**SICP Free Text Online (MIT Press)**

https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-4.html#%_toc_start

**SICP Community Solutions**

http://community.schemewiki.org/?SICP-Solutions
