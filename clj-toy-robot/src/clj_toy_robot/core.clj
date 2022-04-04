(ns clj-toy-robot.core
  (:use [clojure.string :only [lower-case upper-case]]))

(def ^:dynamic *board-size* 5)

(defrecord Position [^Integer x ^Integer y])

(defn safe-dimention [i]
  (cond
    (> i *board-size*) *board-size*
    (< i 0) 0
    :else i))

(defn safe-position [^Integer x ^Integer y]
  (->Position (safe-dimention x) (safe-dimention y)))

(defn compute-move [position direction]
  (let [{x :x y :y} position]
    (case direction
      :north (safe-position x (+ y 1))
      :south (safe-position y (- y 1))
      :east (safe-position (+ x 1) y)
      :west (safe-position (- x 1) y))))

(def turn {
            :left {
                    :north :west
                    :south :east
                    :east :north
                    :west :south}
            :right {
                     :north :east
                     :south :west
                     :east :south
                     :west :north}})

(defn turn-left [direction]
  ((turn :left) direction))

(defn turn-right [direction]
  ((turn :right) direction))

(defprotocol RobotActions
  "The actions a robot can perform"
  (place [this, position direction] "Place a robot on the board")
  (move [this] "Move robot in direction facing")
  (left [this] "Turn left")
  (right [this] "Turn right")
  (report [this] "Report status"))

(defrecord RobotOnBoard [position direction]
  RobotActions
  (place [_ position direction] (->RobotOnBoard position direction))
  (move [_] (->RobotOnBoard (compute-move position direction) direction))
  (left [_] (->RobotOnBoard position (turn-left direction)))
  (right [_] (->RobotOnBoard position (turn-right direction)))
  (report [this] (do
                   (println (format "%d, %d, %s" (:x position) (:y position) (-> direction name upper-case)))
                   this)))

(deftype RobotNotOnBoard []
  RobotActions
  (place [this position direction] (->RobotOnBoard position direction))
  (move [this] this)
  (left [this] this)
  (right [this] this)
  (report [this] (do
                   (println "Robot not on the board")
                   this)))

(defn process-place [robot-state place-fragment]
  (if-let [[match, x-str y-str direction-str] (re-matches #"([0-9]+)?,\s*([0-9]+)?,\s*([A-Z]+)?" place-fragment)]
    (let [x (. Integer parseInt x-str)
          y (. Integer parseInt y-str)
          direction (-> direction-str lower-case keyword)]
      (place robot-state (->Position x y) direction))
    robot-state))

(defn process-command [robot-state full-command]
  (let [[matches command rest] (re-matches #"([A-Z]+)\s*(.*)?" full-command)]
    (case command
      "MOVE" (move robot-state)
      "LEFT" (left robot-state)
      "RIGHT" (right robot-state)
      "REPORT" (report robot-state)
      "PLACE" (process-place robot-state rest))))
