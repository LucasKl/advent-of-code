(import [re [match]])
(import [parsy [regex string seq letter whitespace string_from any_char]])


(setv fields ["byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid" "cid"])

; (print (unpack-iterable fields))

(setv data (with [o (open "res/d4")] (.read o)))

(setv field-parser (seq 
    (<< (string_from "byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid" "cid") (string ":"))
    (regex "[^:\s]+")))

(setv passport-parser 
  (<< 
    (.sep_by field-parser (| (string "\n") (regex " +")) :min 1)
    (regex "\n+")))

(setv data-parser (.many passport-parser))

(defn passport-valid? [passport]
  (setv fields (map first passport))
  (and 
    (or
        (= (len passport) 8)
        (and 
        (= (len passport) 7) 
        (not (in "cid" fields))))
    (reduce and (map field-valid? passport))))

(defn field-valid? [field]
  (setv key (first field))
  (setv value (last field))
  (defn to-int [v] (int (.join "" (drop-last 2 v))))
  (cond 
    [(= key "byr") (and (match "^\d{4}$" value) (and (>= (int value) 1920) (<= (int value) 2002)))]
    [(= key "iyr") (and (match "^\d{4}$" value) (and (>= (int value) 2010) (<= (int value) 2020)))]
    [(= key "eyr") (and (match "^\d{4}$" value) (and (>= (int value) 2020) (<= (int value) 2030)))]
    [(= key "hgt") (and (match "^(\d{3}|\d{2})(cm|in)$" value) 
                     (if 
                       (in "cm" value) (and (>= (to-int value) 150) (<= (to-int value) 193))
                       (and (>= (to-int value) 59) (<= (to-int value) 76))))]
    [(= key "hcl") (bool (match "^#[0-9a-f]{6}$" value))]
    [(= key "ecl") (in value ["amb" "blu" "brn" "gry" "grn" "hzl" "oth"])]
    [(= key "pid") (bool (match "^\d{9}$" value))]
    [(= key "cid") True]
    ))

(setv passports (.parse data-parser data))

(print "D4-1: " (len (list (filter identity (list (map passport-valid? passports))))))