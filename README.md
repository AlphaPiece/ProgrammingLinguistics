# Structure and Interpretation of Computer Programs (SICP)

![Intro Image](https://user-images.githubusercontent.com/30487160/105554188-add52980-5cbb-11eb-92c6-cbace8e01778.png)

*This repository contains all the exercises I did from SICP.*

---

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

---

**Why Structure and Interpretation of Computer Programs matters**:

https://people.eecs.berkeley.edu/~bh/sicp.html

**SICP Free Text Online (MIT Press)**

https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-4.html#%_toc_start

**SICP Community Solutions**

http://community.schemewiki.org/?SICP-Solutions
