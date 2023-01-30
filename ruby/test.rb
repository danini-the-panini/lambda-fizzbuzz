require_relative './lambda'

def assert(x)
  raise unless x
end

assert(to_integer(ZERO) == 0)
assert(to_integer(ONE) == 1)
assert(to_integer(TWO) == 2)
assert(to_integer(THREE) == 3)

assert(to_integer(FIVE) == 5)
assert(to_integer(TEN) == 10)
assert(to_integer(FIFTEEN) == 15)
assert(to_integer(HUNDRED) == 100)

assert(to_boolean(TRUE) == true)
assert(to_boolean(FALSE) == false)

assert(IF[TRUE][:a][:b] == :a)
assert(IF[FALSE][:a][:b] == :b)

assert(to_boolean(IS_ZERO[ZERO]))
assert(!to_boolean(IS_ZERO[ONE]))

assert(to_integer(INCREMENT[ZERO]) == 1)
assert(to_integer(INCREMENT[ONE]) == 2)
assert(to_integer(DECREMENT[THREE]) == 2)
assert(to_integer(DECREMENT[ZERO]) == 0)

assert(to_integer(ADD[THREE][FIVE]) == 8)
assert(to_integer(SUBTRACT[FIVE][THREE]) == 2)
assert(to_integer(SUBTRACT[THREE][FIVE]) == 0)
assert(to_integer(MULTIPLY[THREE][FIVE]) == 15)
assert(to_integer(POWER[FIVE][THREE]) == 125)

assert(to_boolean(IS_LESS_OR_EQUAL[THREE][FIVE]))
assert(to_boolean(IS_LESS_OR_EQUAL[THREE][THREE]))
assert(!to_boolean(IS_LESS_OR_EQUAL[FIVE][THREE]))

assert(to_integer(MOD[FIVE][THREE]) == 2)
assert(to_integer(MOD[THREE][FIVE]) == 3)
assert(to_integer(MOD[THREE][THREE]) == 0)
assert(to_integer(MOD[FIFTEEN][THREE]) == 0)
assert(to_integer(MOD[FIFTEEN][FIVE]) == 0)

assert(to_integer(DIV[FIFTEEN][FIVE]) == 3)
assert(to_integer(DIV[FIFTEEN][THREE]) == 5)
assert(to_integer(DIV[FIFTEEN][TWO]) == 7)

list = UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][THREE]][TWO]][ONE]

assert(to_integer(FIRST[list]) == 1)
assert(to_integer(FIRST[REST[list]]) == 2)
assert(to_integer(FIRST[REST[REST[list]]]) == 3)
assert(!to_boolean(IS_EMPTY[list]))
assert(to_boolean(IS_EMPTY[EMPTY]))
assert(to_array(list).map { |p| to_integer(p) } == [1, 2, 3])

assert(to_array(RANGE[ONE][FIVE]).map { |p| to_integer(p) } == [1, 2, 3, 4, 5])
assert(to_integer(FOLD[RANGE[ONE][FIVE]][ZERO][ADD]) == 15)
assert(to_integer(FOLD[RANGE[ONE][FIVE]][ONE][MULTIPLY]) == 120)
assert(to_array(MAP[RANGE[ONE][FIVE]][INCREMENT]).map { |p| to_integer(p) } == [2, 3, 4, 5, 6])

assert(to_char(ZED) == 'z')
assert(to_string(FIZZBUZZ) == 'FizzBuzz')

assert(to_array(TO_DIGITS[FIVE]).map { |p| to_integer(p) } == [5])
assert(to_array(TO_DIGITS[POWER[FIVE][THREE]]).map { |p| to_integer(p) } == [1, 2, 5])

assert(to_string(TO_DIGITS[FIVE]) == '5')
assert(to_string(TO_DIGITS[POWER[FIVE][THREE]]) == '125')