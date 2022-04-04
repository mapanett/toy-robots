(ns clj-toy-robot.runner
  (:require [clj-toy-robot.core :as core])
  (:gen-class))

(defn -main
  "Application entry point"
  [& args]
  (comment Do app initialization here)
  (reduce core/process-command
    (core/->RobotNotOnBoard)
    (line-seq (java.io.BufferedReader. *in*)))
)
