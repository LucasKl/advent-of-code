(setv data (list (sorted (map int (with [o (open "res/d10")] (.readlines o))))))
(.append data (+ (max data) 3))

(defn acc-difference [acc next]
  (setv diff1 (first acc))
  (setv diff2 (second acc))
  (setv diff3 (nth acc 2))
  (setv prev (nth acc 3))
  (if (= (- next prev) 1) (, (+ diff1 1) diff2 diff3 next)
      (= (- next prev) 2) (, diff1 (+ diff2 1) diff3 next)
      (= (- next prev) 3) (, diff1 diff2 (+ diff3 1) next)
      True acc))

(setv adapter-chain (reduce acc-difference data (, 0 0 0 0)))
(print "D10-1: " (* (first adapter-chain) (nth adapter-chain 2)))

(defn one-chain [acc next]
  (setv prev (first acc))
  (setv curr (second acc))
  (setv chains (nth acc 2))
  (if (= prev (- next 1)) (, next (+ curr 1) chains)
      (do
        (.append chains curr)
        (, next 0 chains))))

(defn combinations [next]
  (if (= next 2) 2
      (= next 3) 4
      (= next 4) 7
      True 1))
      
(setv diffs (filter (fn [x] (> x 1)) (nth (reduce one-chain data (, 0 0 [])) 2)))
(print "D10-2: " (reduce * (map combinations diffs)))
