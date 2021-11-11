(import [util [flatten]])

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
    (if (= mbit "0") bit
        (= mbit "1") "1"
        "X"))
  (.join "" (map mask-bit masked)))

(defn unfloat [head address]
  (if address
      (if (!= (first address) "X") (unfloat (+ head (first address)) (cut address 1))
          [(unfloat (+ head "0") (cut address 1)) (unfloat (+ head "1") (cut address 1))])
      [head]))

;;(print (list (chain.from_iterable (unfloat "" "XX"))))

(defn execute [state line]
  (setv args (.split line "="))
  (setv command (first args))
  (setv value (.strip (second args)))
  (if (= command "mask ") (State state.mem value)
      (do
        (setv index (.join "" (cut command 4 -2)))
        (setv addresses (flatten (unfloat "" (apply-mask (int index) state.mask))))
        ;(print (list (chain.from_iterable addresses)))
        (for [address addresses]
          (assoc state.mem (int (.join "" address) 2) (int value)))
        (State state.mem state.mask))))

(setv program (with [o (open "res/d14")] (.splitlines (.read o))))
(setv res (reduce execute program (State {} "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")))
(print "D14-2:" (sum (.values res.mem)))
