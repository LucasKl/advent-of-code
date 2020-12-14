(import [math [ceil]])
;; from pulp import LpMaximize, LpProblem, LpStatus, lpSum, LpVariable


(setv data (with [o (open "res/d13")] (.readlines o)))
(setv earliest (int (first data)))
(setv buses (map int (filter (fn [x] (x.isnumeric)) (.split (second data) ","))))

(defn solve [earliest t]
  (, (* (ceil (/ earliest t)) t) t))

(setv earliest-bus (min (list (map (fn [bus] (solve earliest bus)) buses))))

(print "D13-1:" (* (- (first earliest-bus) earliest) (second earliest-bus)))

;; puzzle 2
(setv buses (list (.split (second data) ",")))
(setv l (reduce * (map int (filter (fn [x] (x.isnumeric)) buses))))
(setv b-prev (int (first buses)))
(setv step b-prev)
(setv offset 1)
(for [b (drop 1 buses)]
  (if (.isnumeric b)
      (do
        (while (!= (% (+ l offset) (int b)) 0)
          (setv l (- l step)))
        (setv step (* step (int b)))
        (setv b-prev (int b))
        (setv l (+ offset l))
        (setv offset 1))
      True (setv offset (+ 1 offset))))

(print "D13-2:" (- l (len buses) -1))
