(import [itertools [product chain]])

(setv seatmap (list (map list (with [o (open "res/d11")] (.splitlines (.read o))))))

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

(defn get-seat-value [seats x y]
  (setv seat (get-seat seats x y))
  (if (= seat ".") 0
      (= seat "L") 0
      (= seat "#") 1
      True 0))

(defn get-seat-neighbours [seats x y]
  (+
    (get-seat-value seats (- x 1) (- y 1))
    (get-seat-value seats x (- y 1))
    (get-seat-value seats (+ x 1) (- y 1))
    
    (get-seat-value seats (- x 1) y)
    (get-seat-value seats (+ x 1) y)
    
    (get-seat-value seats (- x 1) (+ y 1))
    (get-seat-value seats x (+ y 1))
    (get-seat-value seats (+ x 1) (+ y 1))))

(defn get-seat-next [seats pos]
  (setv x (first pos))
  (setv y (second pos))
  (setv state (get-seat seats x y))
  (setv neighbours (get-seat-neighbours seats x y))
  (if
    (= state "L") (if (= neighbours 0) "#" "L")
    (= state "#") (if (> neighbours 3) "L" "#")
    True state))

(defn count-occupied [seats]
  (.count (list (chain.from_iterable seats)) "#"))

(pad-seatmap seatmap)

;(setv positions (gen-positions (- (len (first seatmap)) 2)))
(setv positions (gen-positions 96 91))

; from hy tutorial
(defmacro do-while [condition body]
  `(do ~body (while ~condition ~body)))

(setv seatmap-new (.copy seatmap))
;(print (!= seatmap seatmap-new) seatmap seatmap-new)
(do-while (!= seatmap seatmap-new)
  (do
    (setv seatmap (.copy seatmap-new))
    (setv seatmap-new (lfor row positions (list (map (fn [pos] (get-seat-next seatmap pos)) row))))
    (pad-seatmap seatmap-new)))

;(print-seatmap seatmap)
(print (count-occupied seatmap))

