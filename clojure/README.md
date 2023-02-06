# Lambda FizzBuzz in Clojure

```
λf.λx.f (f x)
```
⬇️
```clojure
(fn [f] (fn [x] (f (f x))))
```

## Prerequisites

1. [OpenJDK](https://adoptium.net/)
2. [Leiningen](https://codeberg.org/leiningen/leiningen)

## Running

```
lein run
```

To run tests:

```
lein test
```
