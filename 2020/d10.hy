(setv data (list (sorted (map int (with [o (open "res/d10")] (.readlines o))))))
(.append data (+ (max data) 3))

(defn acc-difference [acc next]
  (setv diff1 (first acc))
  (setv diff3 (second acc))
  (setv prev (nth acc 2))
  (if (= (- next prev) 1) (, (+ diff1 1) diff3 next)
      (= (- next prev) 3) (, diff1 (+ diff3 1) next)
      True acc))

(setv adapter-chain (reduce acc-difference data (, 0 0 0)))
(print "D10-1: " (* (first adapter-chain) (second adapter-chain)))
