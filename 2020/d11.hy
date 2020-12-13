(import [itertools [product chain]])

(setv data (list (map list (with [o (open "res/d11")] (.splitlines (.read o))))))

(defn gen-positions [sizex sizey]
  (setv pos [])
  (for [y (range 1 (+ 1 sizey))]
    (setv row [])
    (for [x (range 1 (+ 1 sizex))]
      (.append row (, x y)))
    (.append pos row))
  pos)

(defn pad-seatmap [seats]
  (.append seats (list (take (len (second seats)) (repeat "~"))))
  (.reverse seats)
  (.append seats (list (take (len (second seats)) (repeat "~"))))
  (.reverse seats)
  (for [row seats]
    (.append row "~")
    (.reverse row)
    (.append row "~")
    (.reverse row)))

(defn print-seatmap [seats]
  (for [row seats]
    (for [seat row]
      (print seat :end ""))
    (print)))

(defn get-seat [seats x y]
  (nth (nth seats y) x))

(defn get-seat-value [seats x y dx dy]
  (setv seat (get-seat seats x y))
  (if (= seat ".") 0
      (= seat "L") 0
      (= seat "#") 1
      True 0))

(defn get-nearest-seat-value [seats x y dx dy]
  (setv seat (get-seat seats x y))
  (if (= seat ".") (get-nearest-seat-value seats (+ x dx) (+ y dy) dx dy)
      (= seat "L") 0
      (= seat "#") 1
      True 0))

(defn get-seat-neighbours [seats seat-value-fun x y]
  (+
    (seat-value-fun seats (- x 1) (- y 1) -1 -1)
    (seat-value-fun seats x (- y 1) 0 -1)
    (seat-value-fun seats (+ x 1) (- y 1) 1 -1)
    
    (seat-value-fun seats (- x 1) y -1 0)
    (seat-value-fun seats (+ x 1) y 1 0)
    
    (seat-value-fun seats (- x 1) (+ y 1) -1 1)
    (seat-value-fun seats x (+ y 1) 0 1)
    (seat-value-fun seats (+ x 1) (+ y 1) 1 1)))

(defn get-seat-next [seats seat-value-fun threshold pos]
  (setv x (first pos))
  (setv y (second pos))
  (setv state (get-seat seats x y))
  (setv neighbours (get-seat-neighbours seats seat-value-fun x y))
  (if
    (= state "L") (if (= neighbours 0) "#" "L")
    (= state "#") (if (> neighbours threshold) "L" "#")
    True state))

(defn count-occupied [seats]
  (.count (list (chain.from_iterable seats)) "#"))

; from hy tutorial
(defmacro do-while [condition body]
  `(do ~body (while ~condition ~body)))

(defn simulate [data seat-fun threshold]
  (setv seatmap data)
  (setv positions (gen-positions (len (first data)) (len data)))
  (pad-seatmap seatmap)
  (setv seatmap-new (.copy seatmap))
  (do-while (!= seatmap seatmap-new)
            (do
              (setv seatmap (.copy seatmap-new))
              (setv seatmap-new (lfor row positions (list (map (fn [pos] (get-seat-next seatmap seat-fun threshold pos)) row))))
              (pad-seatmap seatmap-new)))
  (count-occupied seatmap-new))

;(print-seatmap seatmap)
(print "D11-1: " (simulate data get-seat-value 3))
(print "D11-2: " (simulate data get-nearest-seat-value 4))

