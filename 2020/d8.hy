(setv data (with [o (open "res/d8")] (.readlines o)))

(defn parse-instr [line]
  (setv fields (.split (.replace line "\n" "") " "))
  [(first fields) (int (second fields))])

(setv instructions (list (enumerate (map parse-instr (with [o (open "res/d8")] (.readlines o))))))
(setv prog-len (len instructions))

(defn eval [pc acc prog visited]
  (if (>= pc prog-len)
    (, acc True)
    (do 
      (setv instrt (get prog pc))
      ;(print pc acc instrt)
      (setv op (first (second instrt)))
      (setv rs (second (second instrt)))
      (if (in pc visited)
        (, acc False)
        (do
          (.append visited pc)
          (cond
            [(= op "acc") (eval (+ pc 1) (+ acc rs) prog visited)]
            [(= op "jmp") (eval (+ pc rs) acc prog visited)]
            [True (eval (+ pc 1) acc prog visited)]))))))

(print "D8-1: " (first (eval 0 0 instructions [])))

                                ; Second puzzle
(setv progs [(, 0 instructions)])
(for [instr instructions]
  (setv pc (first instr))
  (setv op (first (second instr)))
  (setv rs (second (second instr)))
  (defn change-op [op] (if (= op "jmp") "nop" "jmp"))
  (if (or (= op "nop") (= op "jmp"))
      (do
        (setv new (.copy instructions))
        (assoc new pc (, pc [(change-op op) rs]))
        (.append progs (, pc new)))))

                                ; evaluate all programs
(setv evaluated-progs (list (map (fn [prog] (, (first prog) (eval 0 0 (second prog) []))) progs)))
                                ; filter all failed results
(setv filtered-results (first (filter (fn [x] (-> x second second)) evaluated-progs)))
(print "DP8-2: " (-> filtered-results second first))
