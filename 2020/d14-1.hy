(defclass State []
  (defn __init__ [self mem mask]
    (setv self.mem mem)
    (setv self.mask mask))

  (defn __str__ [self]
    (+ (str self.mem) " \"" self.mask "\"")))

(defn apply-mask [num mask]
  (setv masked (zip (format num "036b") mask))
  (defn mask-bit [pair]
    (setv bit (first pair))
    (setv mbit (second pair))
    (if (= mbit "X") bit
         mbit))  
  (int (.join "" (map mask-bit masked)) 2))

(defn execute [state line]
  (setv args (.split line "="))
  (setv command (first args))
  (setv value (.strip (second args)))
  (if (= command "mask ") (State state.mem value)
      (do
        (setv index (.join "" (cut command 4 -2)))
        (assoc state.mem index (apply-mask (int value) state.mask))
        (State state.mem state.mask))))

(setv program (with [o (open "res/d14")] (.splitlines (.read o))))

(setv res (reduce execute program (State {} "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")))
(print "D14-1:" (sum (.values res.mem)))
