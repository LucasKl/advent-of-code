(import [parsy [regex string seq letter whitespace string_from any_char]])

(setv group (.many (.map (<< (regex "[a-z]+") (string "\n")) set)))
(setv groups (.sep_by group (string "\n")))

(defn count-answers [group]
  (setv head (first group))
  (setv tail (drop 1 group))
  (len (reduce 
         (fn [acc x] (.intersection acc (set x))) tail head)))

(setv data (with [o (open "res/d6")] (.read o)))
(setv parsed-groups (.parse groups data))

;(print (first parsed-groups))
(print "D6-1: " (count-answers (first parsed-groups)))
(print "D7-1: " (sum (list (map count-answers parsed-groups))))