#lang racket/base

(require racket/port)
(require racket/list)
(require algorithms)
(require advent-of-code/input)
(require advent-of-code/meta)
(require advent-of-code/answer)

(define input (open-aoc-input (find-session) 2021 1 #:cache "cache/d1.cache"))
(define depths (map string->number (port->lines input)))

(define (changes data)
  (for/fold ([acc 0]
             [prev 0]
             #:result (- acc 1))
            ([depth data])
    (values
     (if (> depth prev) (add1 acc) acc)
     depth)))

(define d1-1 (changes depths))
(print d1-1)

(aoc-submit (find-session) 2021 1 1 d1-1)

(define slices (for/fold ([slices '()]
                          [rest depths]
                          #:result (reverse slices))
                         ([next depths])
                 (define slice (sum (if (> (length rest) 2) (take rest 3) '())))
                 (values (cons slice slices) (cdr rest))))

(define d1-2 (changes slices))

(aoc-submit (find-session) 2021 1 2 d1-2)




