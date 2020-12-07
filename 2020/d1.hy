(setv nums (list (map int (with [o (open "res/d1")] (.readlines o)))))
(setv nmin (min nums))
(setv nmax (max nums))

(setv candidates-1
    (list (filter 
        (fn [x] (<= (+ x nmin) 2020))
        nums)))

(print "D1-1: " :end "")
(defn d1-1 [lnums]
    (for [n lnums]
        (for [m lnums]
                (when (= (+ n m) 2020) (print (* n m)) (return)))))
(d1-1 candidates-1)

(setv candidates-2
    (list (filter 
        (fn [x] (<= (+ x nmin) 2020))
        nums)))

(print "D1-2: " :end "")
(defn d1-2 [lnums]
    (for [n lnums]
        (for [m lnums]
            (for [o lnums]
                (when (= (+ n m o) 2020) (print (* n m o)) (return))))))
(d1-2 candidates-2)