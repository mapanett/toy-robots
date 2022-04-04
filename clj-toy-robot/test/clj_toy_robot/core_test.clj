(ns clj-toy-robot.core-test
  (:require [clojure.test :refer :all]
            [clj-toy-robot.core :as core]))

(deftest process-place-test
  (testing "process place fragment"
    (is (= (core/->RobotOnBoard (core/->Position 1 1) :north)
          (core/process-place (core/->RobotNotOnBoard) "1, 1, NORTH")))))

(deftest safe-dimention-test
  (testing "safe-dimention"
    (are [expected actual] (= expected actual)
      0 (core/safe-dimention -1)
      0 (core/safe-dimention 0)
      1 (core/safe-dimention 1)
      5 (core/safe-dimention 5)
      5 (core/safe-dimention 6))))

(deftest compute-move-test
  (testing "compute-move"
    (are [expected-x expected-y x y direction]
      (= (core/->Position expected-x expected-y)
        (core/compute-move (core/->Position x y) direction))
      5 5 5 5 :north
      0 0 0 0 :south
      1 2 1 1 :north
      1 0 1 1 :south
      2 1 1 1 :east
      0 1 1 1 :west)))

(deftest turning-test
  (testing "turn-right"
    (are [expected actual] (= expected (core/turn-right actual))
      :east :north
      :west :south
      :south :east
      :north :west))

  (testing "turn-left"
    (are [expected actual] (= expected (core/turn-left actual))
      :west :north
      :east :south
      :north :east
      :south :west)))

(deftest process-command-test
  (testing "MOVE"
    (is (= (core/->RobotOnBoard (core/->Position 1 1) :north)
          (core/process-command (core/->RobotOnBoard (core/->Position 1 0) :north) "MOVE"))))

  (testing "LEFT"
    (is (= (core/->RobotOnBoard (core/->Position 1 1) :west)
          (core/process-command (core/->RobotOnBoard (core/->Position 1 1) :north) "LEFT"))))

  (testing "RIGHT"
    (is (= (core/->RobotOnBoard (core/->Position 1 1) :east)
          (core/process-command (core/->RobotOnBoard (core/->Position 1 1) :north) "RIGHT"))))

  (testing "REPORT"
    (let [robot (core/->RobotOnBoard (core/->Position 1 1) :north)]
      (is (identical? robot
            (core/process-command robot "REPORT"))))))

