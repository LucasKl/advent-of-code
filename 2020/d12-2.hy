(import [math [cos sin radians]])

(defclass Ship []
  (defn __init__ [self x y dirx diry]
    (setv self.x x)
    (setv self.y y)
    (setv self.dirx dirx)
    (setv self.diry diry))

    (defn manhatten [self]
      (+ (abs self.x) (abs self.y)))

  (defn __str__ [self]
    (+ "x: " (str self.x) " y: " (str self.y) " | dx: " (str self.dirx) " dy: " (str self.diry))))

(defclass Command []
  (defn __init__ [self text]
    (setv self.action (first text))
    (setv self.value (int (cut text 1)))))

(defn rotate [x y d]
  (setv d (radians d))
  (setv cosd (round (cos d)))
  (setv sind (round (sin d)))
  (,
    (- (* x cosd) (* y sind))
    (+ (* x sind) (* y cosd))))

(defn move [ship command]
  (if (= command.action "N") (Ship ship.x ship.y ship.dirx (+ ship.diry command.value))
      (= command.action "S") (Ship ship.x ship.y ship.dirx (- ship.diry command.value))
      (= command.action "E") (Ship ship.x ship.y (+ ship.dirx command.value) ship.diry)
      (= command.action "W") (Ship ship.x ship.y (- ship.dirx command.value) ship.diry)
      (= command.action "F") (Ship (+ ship.x (* command.value ship.dirx)) (+ ship.y (* command.value ship.diry)) ship.dirx ship.diry)
      True (if
             (= command.action "L") (do
                                      (setv rotated-dir (rotate ship.dirx ship.diry (+ command.value)))
                                      (Ship ship.x ship.y (first rotated-dir) (second rotated-dir)))
             (= command.action "R") (do
                                      (setv rotated-dir (rotate ship.dirx ship.diry (- command.value)))                                  
                                      (Ship ship.x ship.y (first rotated-dir) (second rotated-dir))))))


(setv commands (list (map Command (with [o (open "res/d12")] (.splitlines (.read o))))))

(print "D12-2:" (.manhatten (reduce move commands (Ship 0 0 10 1))))

