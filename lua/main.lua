local L = require("lambda")

local fizzbuzz = L.MAP(L.RANGE(L.ONE)(L.HUNDRED))(function(n)
  return L.IF(L.IS_ZERO(L.MOD(n)(L.FIFTEEN)))(
    L.FIZZBUZZ
  )(L.IF(L.IS_ZERO(L.MOD(n)(L.THREE)))(
    L.FIZZ
  )(L.IF(L.IS_ZERO(L.MOD(n)(L.FIVE)))(
    L.BUZZ
  )(
    L.TO_DIGITS(n)
  )))
end)

for k, v in pairs(L.map(L.to_table(fizzbuzz), L.to_string)) do
  print(v)
end