(import [parsy [regex string seq letter whitespace string_from any_char decimal_digit]])

(setv parse-bag (<< (regex "\w+ \w+") (regex " (bags|bag)")))
(setv parse-nbag (seq (<< (.map decimal_digit int) (string " ")) parse-bag))
(setv parse-type
  (<<
    (seq
      (<< parse-bag (string " contain "))
      (.__or__
        (<< (.sep_by parse-nbag (string ", ")) (string "."))
        (.result (string "no other bags.") [])))
    (string "\n")))

(setv data (with [o (open "res/d7")] (.readlines o)))
(setv types (dict (map (fn [l] (.parse parse-type l)) data)))


(defn contains-gold? [key]
  (setv sub (list (map second (get types key))))
  (if (= key "shiny gold")
    False
    (if sub
      (if (in "shiny gold" sub)
        True
        (reduce or (map contains-gold? sub)))
      False))) ; (reduce or (map contains-gold? types)))


(defn count-bags [key]
  (setv sub (get types key))
  (if (= (len sub) 0)
    0
      (sum (list (map
                     (fn [p]
		       (+ (first p) (* (first p) (count-bags (second p)))))
		     sub)))))
      

(print "D7-1: " (len (list (filter identity (map contains-gold? (.keys types))))))
(print "D7-2: " (count-bags "shiny gold"))
