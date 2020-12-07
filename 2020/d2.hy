;; Python: from os.path import exists, isdir, isfile
(import [parsy [regex string seq letter whitespace]])

(defn parse [line]    
    (.parse 
        (seq
            (.map (regex "[0-9]+") int)
            (string "-")
            (.map (regex "[0-9]+") int)
            whitespace
            letter
            (string ":")
            whitespace
            (regex "[a-zA-Z]+\n")
        ) line))

(defn valid-1? [data]
    (setv txt (last data))
    (setv char (nth data 4))
    (setv count (.count txt char))
        (and
            (>= count (nth data 0 ))
            (<= count (nth data 2))))

(defn valid-2? [data]
    (setv txt (last data))
    (setv char (nth data 4))
    (setv p1 (- (nth data 0) 1))
    (setv p2 (- (nth data 2) 1))
    (xor
        (= (nth txt p1) char)
        (= (nth txt p2) char)))

(setv pwd (list (map parse (with [o (open "res/d2")] (.readlines o)))))

(print "D2-1: " (len (list (filter identity (map valid-1? pwd)))))
(print "D2-2: " (len (list (filter identity (map valid-2? pwd)))))