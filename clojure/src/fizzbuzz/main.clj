(ns fizzbuzz.main
  (:require [fizzbuzz.lambda :refer :all]))

(def fizzbuzz ((MAP ((RANGE ONE) HUNDRED)) (fn [n]
  (((IF (IS-ZERO ((MOD n) FIFTEEN)))
    FIZZBUZZ)
  (((IF (IS-ZERO ((MOD n) THREE)))
    FIZZ)
  (((IF (IS-ZERO ((MOD n) FIVE)))
    BUZZ)
    (TO-DIGITS n)))))))

(defn main []
  (dorun (map println (map to-string (to-list fizzbuzz)))))