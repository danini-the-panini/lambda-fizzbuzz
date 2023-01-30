import {
  toInteger, toBoolean, toArray, toChar, toString,
  ZERO, ONE, TWO, THREE, FIVE, TEN, FIFTEEN, HUNDRED,
  TRUE, FALSE,
  IF,
  IS_ZERO,
  INCREMENT, DECREMENT,
  ADD, SUBTRACT, MULTIPLY, POWER,
  IS_LESS_OR_EQUAL,
  MOD,
  DIV,
  EMPTY, UNSHIFT, IS_EMPTY, FIRST, REST,
  RANGE,
  FOLD, MAP,
  ZED, FIZZBUZZ,
  TO_DIGITS
} from './lambda.js';

function assert(x) {
  if (!x) throw new Error;
}

function arrEquals(a, b) {
  if (a.length !== b.length) return false;
  for (let i = 0; i < a.length; i++) {
    if (a[i] !== b[i]) return false;
  }
  return true;
}

assert(toInteger(ZERO) === 0);
assert(toInteger(ONE) === 1);
assert(toInteger(TWO) === 2);
assert(toInteger(THREE) === 3);

assert(toInteger(FIVE) === 5);
assert(toInteger(TEN) === 10);
assert(toInteger(FIFTEEN) === 15);
assert(toInteger(HUNDRED) === 100);

assert(toBoolean(TRUE) === true);
assert(toBoolean(FALSE) === false);

assert(IF(TRUE)('a')('b') === 'a');
assert(IF(FALSE)('a')('b') === 'b');

assert(toBoolean(IS_ZERO(ZERO)));
assert(!toBoolean(IS_ZERO(ONE)));

assert(toInteger(INCREMENT(ZERO)) === 1);
assert(toInteger(INCREMENT(ONE)) === 2);
assert(toInteger(DECREMENT(THREE)) === 2);
assert(toInteger(DECREMENT(ZERO)) === 0);

assert(toInteger(ADD(THREE)(FIVE)) === 8);
assert(toInteger(SUBTRACT(FIVE)(THREE)) === 2);
assert(toInteger(SUBTRACT(THREE)(FIVE)) === 0);
assert(toInteger(MULTIPLY(THREE)(FIVE)) === 15);
assert(toInteger(POWER(FIVE)(THREE)) === 125);

assert(toBoolean(IS_LESS_OR_EQUAL(THREE)(FIVE)));
assert(toBoolean(IS_LESS_OR_EQUAL(THREE)(THREE)));
assert(!toBoolean(IS_LESS_OR_EQUAL(FIVE)(THREE)));

assert(toInteger(MOD(FIVE)(THREE)) === 2);
assert(toInteger(MOD(THREE)(FIVE)) === 3);
assert(toInteger(MOD(THREE)(THREE)) === 0);
assert(toInteger(MOD(FIFTEEN)(THREE)) === 0);
assert(toInteger(MOD(FIFTEEN)(FIVE)) === 0);

assert(toInteger(DIV(FIFTEEN)(FIVE)) === 3);
assert(toInteger(DIV(FIFTEEN)(THREE)) === 5);
assert(toInteger(DIV(FIFTEEN)(TWO)) === 7);

let list = UNSHIFT(UNSHIFT(UNSHIFT(EMPTY)(THREE))(TWO))(ONE);

assert(toInteger(FIRST(list)) === 1);
assert(toInteger(FIRST(REST(list))) === 2);
assert(toInteger(FIRST(REST(REST(list)))) === 3);
assert(!toBoolean(IS_EMPTY(list)));
assert(toBoolean(IS_EMPTY(EMPTY)));
assert(arrEquals(toArray(list).map(toInteger), [1, 2, 3]));

assert(arrEquals(toArray(RANGE(ONE)(FIVE)).map(toInteger), [1, 2, 3, 4, 5]));
assert(toInteger(FOLD(RANGE(ONE)(FIVE))(ZERO)(ADD)) === 15);
assert(toInteger(FOLD(RANGE(ONE)(FIVE))(ONE)(MULTIPLY)) === 120);
assert(arrEquals(toArray(MAP(RANGE(ONE)(FIVE))(INCREMENT)).map(toInteger), [2, 3, 4, 5, 6]));

assert(toChar(ZED) === 'z');
assert(toString(FIZZBUZZ) === 'FizzBuzz');

assert(arrEquals(toArray(TO_DIGITS(FIVE)).map(toInteger), [5]));
assert(arrEquals(toArray(TO_DIGITS(POWER(FIVE)(THREE))).map(toInteger), [1, 2, 5]));

assert(toString(TO_DIGITS(FIVE)) === '5');
assert(toString(TO_DIGITS(POWER(FIVE)(THREE))) === '125');