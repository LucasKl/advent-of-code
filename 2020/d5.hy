(defn seat-id [data] (+ (* (first data) 8) (second data)))

(defn get-seat [ticket] 
  (setv row-ticket (.join "" (list (drop-last 4 ticket))))
  (setv column-ticket (.join "" (list (drop 7 ticket))))
  (defn decode [ticket code]
    (int (.replace (.replace ticket (first code) "1") (second code) "0") 2))
  [(decode row-ticket "BF") (decode column-ticket "RL")])

(setv data (with [o (open "res/d5")] (.readlines o)))
(setv ids (list (map seat-id (map get-seat data))))

(defn test-id [id]
  (setv match (and (not (in (- id 1) ids)) (in (- id 2) ids)))
  (if match (- id 1) None))

(print "D5-1: " (max ids))
(print "D5-2: " (first (list (filter identity (map test-id ids)))))
