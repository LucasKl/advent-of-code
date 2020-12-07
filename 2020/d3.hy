(setv geo (with [o (open "res/d3")] (.readlines o)))
(setv geo-len  31)

(defn get-loc [x y]
    (nth (nth geo y) (% x geo-len)))

(defn count-trees [slope]
    (setv trees 0)
    (setv x 0)
    (for [y (range 0 (len geo) (last slope))]
        (when (= (get-loc x y) "#") (setv trees (+ trees 1)))
        (setv x (+ x (first slope))))
    trees)

(setv slopes [[1 1] [3 1] [5 1] [7 1] [1 2]])
(print "D3-2: " (reduce * (list (map count-trees slopes))))