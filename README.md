# Lambda FizzBuzz!

[FizzBuzz](https://en.wikipedia.org/wiki/Fizz_buzz) written in pure [Lambda Calculus](https://en.wikipedia.org/wiki/Lambda_calculus) in various languages.

Inspired by [this](https://tomstu.art/programming-with-nothing).

| Language           | Time    |
|--------------------|---------|
| [Ruby](ruby)       | 6.68s   |
| [JavaScript](js)   | 0.79s   |
| [Python](python)   | 5.39s   |
| [Clojure](clojure) | 2.26s   |
| [PHP](php)         | 5.42s   |
| [Lua](lua)         | 4.25s   |
| [Julia](julia)     | 21m 41s |

Failures:

1. C++ fails complains about types with mod/z-combinator
2. Crystal/Rust/Java/Scala lambdas require parameter type at compile time
3. Haskell complains about types with subtract
4. Elm hangs and crashes with subtract