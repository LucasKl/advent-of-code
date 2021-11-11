(defn day15 [last]
      (setv spoken {16 1  11 2  15 3  0 4  1 5})
      (setv now 7)
      (setv prev 7)

      (for [turn (range (+ (len spoken) 1) (+ last 1))]
      	   (setv prev now)
     	   (setv now (if (in prev spoken)
     	       	     (- turn (get spoken prev))
	 	     0))
     	   (assoc spoken prev turn))
      prev)

(print "Puzzle 15-1:" (day15 2020))
(print "Puzzle 15-2:" (day15 30000000))