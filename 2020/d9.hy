(import [itertools [product]])
(import [math [floor]])

(defn build-keys [preamble]
  (set (map
    (fn [pair] (+ (first pair) (second pair)))
    (filter
      (fn [x] (!= (first x) (second x)))
      (product preamble preamble)))))

(defn validate [data]
  (setv keys (build-keys (list (take 25 data))))
  (setv numbers (list (drop 25 data)))
  (if (in (first numbers) keys)
      (validate (list (drop 1 data)))
      (first numbers)))

; from hy tutorial
(defmacro do-while [condition body]
  `(do ~body (while ~condition ~body)))

(defn find-weakness [data low high target]
  (do-while (!= (sum window) target)
            (do
              (setv window (cut data low high))
                (if
                  (< (sum window) target) (setv high (+ high 1))
                  (> (sum window) target) (setv low (+ low 1) high (+ low 2)))))
  window)

(setv data (list (map int (with [o (open "res/d9")] (.readlines o)))))
(setv invalid-number (validate data))
(print "D9-1: " invalid-number)

(setv weak-range (find-weakness data 0 1 invalid-number))
(print "D9-2: " (+ (min weak-range) (max weak-range)))
