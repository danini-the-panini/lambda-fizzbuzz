import {
  toArray,
  toString,
  ONE,
  THREE,
  FIVE,
  FIFTEEN,
  HUNDRED,
  IF,
  IS_ZERO,
  MOD,
  RANGE,
  MAP,
  FIZZ,
  BUZZ,
  FIZZBUZZ,
  TO_DIGITS
} from './lambda.js';

let fizzbuzz = MAP(RANGE(ONE)(HUNDRED))(n =>
  IF(IS_ZERO(MOD(n)(FIFTEEN)))(
    FIZZBUZZ
  )(IF(IS_ZERO(MOD(n)(THREE)))(
    FIZZ
  )(IF(IS_ZERO(MOD(n)(FIVE)))(
    BUZZ
  )(
    TO_DIGITS(n)
  )))
);

console.log(toArray(fizzbuzz).map(toString).join("\n"));