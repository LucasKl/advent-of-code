(import [math [ceil]])
;; from pulp import LpMaximize, LpProblem, LpStatus, lpSum, LpVariable


(setv data (with [o (open "res/d13")] (.readlines o)))
(setv earliest (int (first data)))
(setv buses (map int (filter (fn [x] (x.isnumeric)) (.split (second data) ","))))

(defn solve [earliest t]
  (, (* (ceil (/ earliest t)) t) t))

(setv earliest-bus (min (list (map (fn [bus] (solve earliest bus)) buses))))

;;(print "D13-1:" (* (- (first earliest-bus) earliest) (second earliest-bus)))

;; puzzle 2
(import [pulp [LpMinimize LpProblem LpVariable]])

(setv buses (list (.split (second data) ",")))
(setv model (LpProblem :sense LpMinimize))
(setv t (LpVariable "t" 100000000000000 :cat "Integer"))
;;(setv t (LpVariable "t" 0 :cat "Integer"))

(+= model t)
(+= model (<= t 450000000000000))

(for [i (range (len buses))]
  (setv schedule (nth buses i))
  (print schedule)
  (if (.isnumeric schedule)
      (do
        (setv x (LpVariable (+ "x" (str i)) 0 :cat "Integer"))
        (+= model (= (* (int schedule) x) (+ t i))) )))

;(+= model (>= t 1202161486))
;(+= model (>= t 10000))

(print model)
(.solve model)
(print (.variables model))
(setv val-t (second (.variables model)))
(for [var (.variables model)]
  (print var (.value var)))
