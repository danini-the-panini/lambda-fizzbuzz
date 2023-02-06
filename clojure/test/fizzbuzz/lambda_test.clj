(ns fizzbuzz.lambda-test
  (:require [clojure.test :refer :all]
            [fizzbuzz.lambda :refer :all]))

(deftest church-numerals
  (is (= (to-integer ZERO) 0))
  (is (= (to-integer ONE) 1))
  (is (= (to-integer TWO) 2))
  (is (= (to-integer THREE) 3))

  (is (= (to-integer FIVE) 5))
  (is (= (to-integer TEN) 10))
  (is (= (to-integer FIFTEEN) 15))
  (is (= (to-integer HUNDRED) 100)))

(deftest church-booleans
  (is (to-boolean TRUE))
  (is (not (to-boolean FALSE))))

(deftest if-statement
  (is (= (((IF TRUE) :a) :b) :a))
  (is (= (((IF FALSE) :a) :b) :b)))

(deftest is-zero
  (is (to-boolean (IS-ZERO ZERO)))
  (is (not (to-boolean (IS-ZERO ONE)))))

(deftest increment
  (is (= (to-integer (INCREMENT ZERO)) 1))
  (is (= (to-integer (INCREMENT ONE)) 2)))

(deftest decrement
  (is (= (to-integer (DECREMENT THREE)) 2))
  (is (= (to-integer (DECREMENT ZERO)) 0)))

(deftest arithmetic
  (is (= (to-integer ((ADD THREE) FIVE)) 8))
  (is (= (to-integer ((SUBTRACT FIVE) THREE)) 2))
  (is (= (to-integer ((SUBTRACT THREE) FIVE)) 0))
  (is (= (to-integer ((MULTIPLY THREE) FIVE)) 15))
  (is (= (to-integer ((POWER FIVE) THREE)) 125)))

(deftest is-less-or-equal
  (is (to-boolean ((IS-LESS-OR-EQUAL THREE) FIVE)))
  (is (to-boolean ((IS-LESS-OR-EQUAL THREE) THREE)))
  (is (not (to-boolean ((IS-LESS-OR-EQUAL FIVE) THREE)))))

(deftest modulus
  (is (= (to-integer ((MOD FIVE) THREE)) 2))
  (is (= (to-integer ((MOD THREE) FIVE)) 3))
  (is (= (to-integer ((MOD THREE) THREE)) 0))
  (is (= (to-integer ((MOD FIFTEEN) THREE)) 0))
  (is (= (to-integer ((MOD FIFTEEN) FIVE)) 0)))

(deftest div
  (is (= (to-integer ((DIV FIFTEEN) FIVE)) 3))
  (is (= (to-integer ((DIV FIFTEEN) THREE)) 5))
  (is (= (to-integer ((DIV FIFTEEN) TWO)) 7)))

(def my-list ((UNSHIFT ((UNSHIFT ((UNSHIFT EMPTY) THREE)) TWO)) ONE))

(deftest list-comprehension
  (is (= (to-integer (FIRST my-list)) 1))
  (is (= (to-integer (FIRST (REST my-list))) 2))
  (is (= (to-integer (FIRST (REST (REST my-list)))) 3))
  (is (not (to-boolean (IS-EMPTY my-list))))
  (is (to-boolean (IS-EMPTY EMPTY))))
  (is (= (map to-integer (to-list my-list)) '(1 2 3)))

(deftest ranges
  (is (= (map to-integer (to-list ((RANGE ONE) FIVE))) '(1 2 3 4 5)))
  (is (= (to-integer (((FOLD ((RANGE ONE) FIVE)) ZERO) ADD)) 15))
  (is (= (to-integer (((FOLD ((RANGE ONE) FIVE)) ONE) MULTIPLY)) 120))
  (is (= (map to-integer (to-list ((MAP ((RANGE ONE) FIVE)) INCREMENT))) '(2 3 4 5 6))))

(deftest strings
  (is (= (to-char ZED) \z))
  (is (= (to-string FIZZBUZZ) "FizzBuzz")))

(deftest to-digits
  (is (= (map to-integer (to-list (TO-DIGITS FIVE))) '(5)))
  (is (= (map to-integer (to-list (TO-DIGITS ((POWER FIVE) THREE)))) '(1 2 5))))

(deftest to-digits-to-string
  (is (= (to-string (TO-DIGITS FIVE)) "5"))
  (is (= (to-string (TO-DIGITS ((POWER FIVE) THREE))) "125")))