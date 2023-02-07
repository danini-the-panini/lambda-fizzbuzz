local L = require "lambda"

function table_eq(t1, t2)
  if #t1 ~= #t2 then return false end
  for i=1,#t1 do
    if t1[i] ~= t2[i] then return false end
  end
  return true
end

assert(L.to_integer(L.ZERO) == 0)
assert(L.to_integer(L.ONE) == 1)
assert(L.to_integer(L.TWO) == 2)
assert(L.to_integer(L.THREE) == 3)

assert(L.to_integer(L.FIVE) == 5)
assert(L.to_integer(L.TEN) == 10)
assert(L.to_integer(L.FIFTEEN) == 15)
assert(L.to_integer(L.HUNDRED) == 100)

assert(L.to_boolean(L.TRUE))
assert(not L.to_boolean(L.FALSE))

assert(L.IF(L.TRUE)("a")("b") == "a")
assert(L.IF(L.FALSE)("a")("b") == "b")

assert(L.to_boolean(L.IS_ZERO(L.ZERO)))
assert(not L.to_boolean(L.IS_ZERO(L.ONE)))

assert(L.to_integer(L.INCREMENT(L.ZERO)) == 1)
assert(L.to_integer(L.INCREMENT(L.ONE)) == 2)
assert(L.to_integer(L.DECREMENT(L.THREE)) == 2)
assert(L.to_integer(L.DECREMENT(L.ZERO)) == 0)

assert(L.to_integer(L.ADD(L.THREE)(L.FIVE)) == 8)
assert(L.to_integer(L.SUBTRACT(L.FIVE)(L.THREE)) == 2)
assert(L.to_integer(L.SUBTRACT(L.THREE)(L.FIVE)) == 0)
assert(L.to_integer(L.MULTIPLY(L.THREE)(L.FIVE)) == 15)
assert(L.to_integer(L.POWER(L.FIVE)(L.THREE)) == 125)

assert(L.to_boolean(L.IS_LESS_OR_EQUAL(L.THREE)(L.FIVE)))
assert(L.to_boolean(L.IS_LESS_OR_EQUAL(L.THREE)(L.THREE)))
assert(not L.to_boolean(L.IS_LESS_OR_EQUAL(L.FIVE)(L.THREE)))

assert(L.to_integer(L.MOD(L.FIVE)(L.THREE)) == 2)
assert(L.to_integer(L.MOD(L.THREE)(L.FIVE)) == 3)
assert(L.to_integer(L.MOD(L.THREE)(L.THREE)) == 0)
assert(L.to_integer(L.MOD(L.FIFTEEN)(L.THREE)) == 0)
assert(L.to_integer(L.MOD(L.FIFTEEN)(L.FIVE)) == 0)

assert(L.to_integer(L.DIV(L.FIFTEEN)(L.FIVE)) == 3)
assert(L.to_integer(L.DIV(L.FIFTEEN)(L.THREE)) == 5)
assert(L.to_integer(L.DIV(L.FIFTEEN)(L.TWO)) == 7)

local list = L.UNSHIFT(L.UNSHIFT(L.UNSHIFT(L.EMPTY)(L.THREE))(L.TWO))(L.ONE)

assert(L.to_integer(L.FIRST(list)) == 1)
assert(L.to_integer(L.FIRST(L.REST(list))) == 2)
assert(L.to_integer(L.FIRST(L.REST(L.REST(list)))) == 3)
assert(not L.to_boolean(L.IS_EMPTY(list)))
assert(L.to_boolean(L.IS_EMPTY(L.EMPTY)))
assert(table_eq(L.map(L.to_table(list), L.to_integer), {1, 2, 3}))

assert(table_eq(L.map(L.to_table(L.RANGE(L.ONE)(L.FIVE)), L.to_integer), {1, 2, 3, 4, 5}))
assert(L.to_integer(L.FOLD(L.RANGE(L.ONE)(L.FIVE))(L.ZERO)(L.ADD)) == 15)
assert(L.to_integer(L.FOLD(L.RANGE(L.ONE)(L.FIVE))(L.ONE)(L.MULTIPLY)) == 120)
assert(table_eq(L.map(L.to_table(L.MAP(L.RANGE(L.ONE)(L.FIVE))(L.INCREMENT)), L.to_integer), {2, 3, 4, 5, 6}))

assert(L.to_char(L.Z) == "z")
assert(L.to_string(L.FIZZBUZZ) == "FizzBuzz")

assert(table_eq(L.map(L.to_table(L.TO_DIGITS(L.FIVE)), L.to_integer), {5}))
assert(table_eq(L.map(L.to_table(L.TO_DIGITS(L.POWER(L.FIVE)(L.THREE))), L.to_integer), {1, 2, 5}))

assert(L.to_string(L.TO_DIGITS(L.FIVE)) == "5")
assert(L.to_string(L.TO_DIGITS(L.POWER(L.FIVE)(L.THREE))) == "125")