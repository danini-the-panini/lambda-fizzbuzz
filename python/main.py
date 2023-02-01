from mylambda import *

fizzbuzz = MAP(RANGE(ONE)(HUNDRED))(lambda n:
  IF(IS_ZERO(MOD(n)(FIFTEEN)))(
    FIZZBUZZ
  )(IF(IS_ZERO(MOD(n)(THREE)))(
    FIZZ
  )(IF(IS_ZERO(MOD(n)(FIVE)))(
    BUZZ
  )(
    TO_DIGITS(n)
  )))
)

for x in to_array(fizzbuzz):
  print(to_string(x))