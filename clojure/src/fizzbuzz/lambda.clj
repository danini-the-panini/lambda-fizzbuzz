(ns fizzbuzz.lambda)

(def ZERO  (fn [p] (fn [x] x)))
(def ONE   (fn [p] (fn [x] (p x))))
(def TWO   (fn [p] (fn [x] (p (p x)))))
(def THREE (fn [p] (fn [x] (p (p (p x))))))

(def FIVE    (fn [p] (fn [x] (p (p (p (p (p x))))))))
(def TEN     (fn [p] (fn [x] (p (p (p (p (p (p (p (p (p (p x)))))))))))))
(def FIFTEEN (fn [p] (fn [x] (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p x))))))))))))))))))
(def HUNDRED (fn [p] (fn [x] (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p (p x)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(def TRUE  (fn [x] (fn [y] x)))
(def FALSE (fn [x] (fn [y] y)))

(def IF (fn [b] b))

(def IS-ZERO (fn [n] ((n (fn [x] FALSE)) TRUE)))

(def INCREMENT (fn [n] (fn [p] (fn [x] (p ((n p) x))))))
(def DECREMENT (fn [n] (fn [f] (fn [x]
  (((n (fn [g] (fn [h] (h (g f))))) (fn [u] x)) (fn [u] u))))))

(def ADD      (fn [m] (fn [n] ((n INCREMENT) m))))
(def SUBTRACT (fn [m] (fn [n] ((n DECREMENT) m))))
(def MULTIPLY (fn [m] (fn [n] ((n (ADD m)) ZERO))))
(def POWER    (fn [m] (fn [n] ((n (MULTIPLY m)) ONE))))

(def IS-LESS-OR-EQUAL (fn [m] (fn [n] (IS-ZERO ((SUBTRACT m) n)))))

(def Z (fn [f] ((fn [x] (f (fn [y] ((x x) y)))) (fn [x] (f (fn [y] ((x x) y)))))))

(def MOD (Z (fn [f] (fn [m] (fn [n]
  (((IF ((IS-LESS-OR-EQUAL n) m))
    (fn [x] (((f ((SUBTRACT m) n)) n) x)))
    m))))))

(def DIV (Z (fn [f] (fn [m] (fn [n]
  (((IF ((IS-LESS-OR-EQUAL n) m))
    (fn [x] ((INCREMENT ((f ((SUBTRACT m) n)) n)) x)))
    ZERO))))))

(def PAIR  (fn [x] (fn [y] (fn [f] ((f x) y)))))
(def LEFT  (fn [p] (p (fn [x] (fn [y] x)))))
(def RIGHT (fn [p] (p (fn [x] (fn [y] y)))))

(def EMPTY    ((PAIR TRUE) TRUE))
(def UNSHIFT  (fn [l] (fn [x]
                ((PAIR FALSE) ((PAIR x) l)))))
(def IS-EMPTY LEFT)
(def FIRST    (fn [l] (LEFT (RIGHT l))))
(def REST     (fn [l] (RIGHT (RIGHT l))))

(def RANGE (Z (fn [f] (fn [m] (fn [n]
  (((IF ((IS-LESS-OR-EQUAL m) n))
    (fn [x] (((UNSHIFT ((f (INCREMENT m)) n)) m) x)))
    EMPTY))))))

(def FOLD (Z (fn [f] (fn [l] (fn [x] (fn [g]
  (((IF (IS-EMPTY l))
    x)
    (fn [y] (((g (((f (REST l)) x) g)) (FIRST l)) y)))))))))

(def MAP (fn [k] (fn [f]
  (((FOLD k) EMPTY)
    (fn [l] (fn [x] ((UNSHIFT l) (f x))))))))

(def PUSH (fn [l] (fn [x] (((FOLD l) ((UNSHIFT EMPTY) x)) UNSHIFT))))

(def B   TEN)
(def F   (INCREMENT B))
(def I   (INCREMENT F))
(def U   (INCREMENT I))
(def ZED (INCREMENT U))

(def FIZZ     ((UNSHIFT ((UNSHIFT ((UNSHIFT ((UNSHIFT EMPTY) ZED)) ZED)) I)) F))
(def BUZZ     ((UNSHIFT ((UNSHIFT ((UNSHIFT ((UNSHIFT EMPTY) ZED)) ZED)) U)) B))
(def FIZZBUZZ ((UNSHIFT ((UNSHIFT ((UNSHIFT ((UNSHIFT BUZZ) ZED)) ZED)) I)) F))

(def TO-DIGITS (Z (fn [f] (fn [n]
  ((PUSH
    (((IF ((IS-LESS-OR-EQUAL n) (DECREMENT TEN)))
      EMPTY)
      (fn [x] ((f ((DIV n) TEN)) x)))
  ) ((MOD n) TEN))))))

(defn to-integer [proc]
  ((proc (fn [n] (+ n 1))) 0))

(defn to-boolean [proc]
  ((proc true) false))

(defn to-list [proc]
  (if (to-boolean (IS-EMPTY proc))
    ()
    (cons (FIRST proc) (to-list (REST proc)))))

(defn to-char [c]
  (nth "0123456789BFiuz" (to-integer c)))

(defn to-string [s]
  (apply str (map to-char (to-list s))))