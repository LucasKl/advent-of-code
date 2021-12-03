def toInt(xs):
    return int(''.join([str(1 if x else 0) for x in xs]), 2)

'''

(defun loop (bits indices)
  (print indices)
  (set [a (find/g (&& (in INDEX indices) (test bits)))])
  (print a)
  (if (= (length a) 1)
      a[0]
      (loop (+ bits 1) a)))

(print (loop 1 (find/g #t)))

(defun test (bits)
  (set [tmp (map (fn (i (v g)) (= data[(- 4 i)] v[i])) '(0 1 2 3 4)[0:bits])])
  (! (in #f tmp)))

'''
