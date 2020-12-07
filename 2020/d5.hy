(defn decode [ticket code ids]
  (defmacro nids [ids] '(int (/ (len ids) 2)))
  (setv next-ids
    (cond 
      [(= (first ticket) (first code)) (list (drop-last (nids ids) ids))]
      [(= (first ticket) (second code)) (list (drop (nids ids) ids))]))
    (if 
      (> (len next-ids) 1) (decode (list (drop 1 ticket)) code next-ids)
      (first next-ids)))

(defn seat-id [data] (+ (* (first data) 8) (second data)))

(defn get-seat [ticket] 
  (setv row-ticket (list (drop-last 3 ticket)))
  (setv column-ticket (list (drop 7 ticket)))
  [(decode row-ticket "FB" (list (range 128)))
  (decode column-ticket "LR" (list (range 8)))] )

(setv data (with [o (open "res/d5")] (.readlines o)))


(setv ids (list (map seat-id (map get-seat data))))

(defn test-id [id]
  (setv match (and (not (in (- id 1) ids)) (in (- id 2) ids)))
  (if match (- id 1) None))

(print "D5-1: " (max ids))
(print "D5-2: " (first (list (filter identity (map test-id ids)))))
