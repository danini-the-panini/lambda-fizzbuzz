local L = {}

function L.to_integer(proc)
  return proc(function(n); return n + 1; end)(0)
end

function L.to_boolean(proc)
  return proc(true)(false)
end

function L.to_table(proc)
  local t = {}
  while (not L.to_boolean(L.IS_EMPTY(proc)))
  do
    table.insert(t, L.FIRST(proc))
    proc = L.REST(proc)
  end
  return t
end

function L.map(tbl, f)
  local t = {}
  for k,v in pairs(tbl) do
      t[k] = f(v)
  end
  return t
end

function L.to_char(c)
  local n = L.to_integer(c) + 1
  return string.sub("0123456789BFiuz", n, n)
end

function L.to_string(s)
  return table.concat(L.map(L.to_table(s), L.to_char))
end

L.ZERO  = function(p); return function(x); return x; end; end
L.ONE   = function(p); return function(x); return p(x); end; end
L.TWO   = function(p); return function(x); return p(p(x)); end; end
L.THREE = function(p); return function(x); return p(p(p(x))); end; end

L.FIVE    = function(p); return function(x); return p(p(p(p(p(x))))); end; end
L.TEN     = function(p); return function(x); return p(p(p(p(p(p(p(p(p(p(x)))))))))); end; end
L.FIFTEEN = function(p); return function(x); return p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(x))))))))))))))); end; end
L.HUNDRED = function(p); return function(x); return p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(x)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))); end; end

L.TRUE  = function(x); return function(y); return x; end; end
L.FALSE = function(x); return function(y); return y; end; end

L.IF = function(b); return b; end

L.IS_ZERO = function(n); return n(function (x); return L.FALSE; end)(L.TRUE); end

L.INCREMENT = function(n); return function(p); return function(x); return p(n(p)(x)); end; end; end
L.DECREMENT = function(n); return function(f); return function(x);
  return n(function(g); return function(h); return h(g(f)); end; end)(function(u); return x; end)(function(u); return u; end)
end; end; end

L.ADD      = function(m); return function(n); return n(L.INCREMENT)(m); end; end
L.SUBTRACT = function(m); return function(n); return n(L.DECREMENT)(m); end; end
L.MULTIPLY = function(m); return function(n); return n(L.ADD(m))(L.ZERO); end; end
L.POWER    = function(m); return function(n); return n(L.MULTIPLY(m))(L.ONE); end; end

L.IS_LESS_OR_EQUAL = function(m); return function(n); return L.IS_ZERO(L.SUBTRACT(m)(n)); end; end

local Z = function(f);
  return (function(x); return f(function (y); return x(x)(y); end); end)(
    function(x); return f(function (y); return x(x)(y); end); end
  );
end

L.MOD = Z(function(f); return function(m); return function(n)
  return L.IF(L.IS_LESS_OR_EQUAL(n)(m))(
    function(x); return f(L.SUBTRACT(m)(n))(n)(x); end
  )(
    m
  )
end; end; end)

L.DIV = Z(function (f); return function(m); return function(n)
  return L.IF(L.IS_LESS_OR_EQUAL(n)(m))(
    function (x); return L.INCREMENT(f(L.SUBTRACT(m)(n))(n))(x); end
  )(
    L.ZERO
  )
end; end; end)

L.PAIR  = function(x); return function(y); return function(f); return f(x)(y); end; end; end
L.LEFT  = function(p); return p(function(x); return function(y); return x; end; end); end
L.RIGHT = function(p); return p(function(x); return function(y); return y; end; end); end

L.EMPTY    = L.PAIR(L.TRUE)(L.TRUE)
L.UNSHIFT  = function(l); return function(x); return L.PAIR(L.FALSE)(L.PAIR(x)(l)); end; end
L.IS_EMPTY = L.LEFT
L.FIRST    = function(l); return L.LEFT(L.RIGHT(l)); end
L.REST     = function(l); return L.RIGHT(L.RIGHT(l)); end

L.RANGE = Z(function(f); return function(m); return function(n)
  return L.IF(L.IS_LESS_OR_EQUAL(m)(n))(
    function(x); return L.UNSHIFT(f(L.INCREMENT(m))(n))(m)(x); end
  )(
    L.EMPTY
  )
end; end; end)

L.FOLD = Z(function (f); return function(l); return function(x); return function(g)
    return L.IF(L.IS_EMPTY(l))(
      x
    )(
      function(y); return g(f(L.REST(l))(x)(g))(L.FIRST(l))(y); end
    )
end; end; end; end)

L.MAP = function(k); return function(f)
  return L.FOLD(k)(L.EMPTY)(
    function(l); return function(x); return L.UNSHIFT(l)(f(x)); end; end
  )
end; end

L.PUSH = function(l); return function(x); return L.FOLD(l)(L.UNSHIFT(L.EMPTY)(x))(L.UNSHIFT); end; end

L.B = L.TEN
L.F = L.INCREMENT(L.B)
L.I = L.INCREMENT(L.F)
L.U = L.INCREMENT(L.I)
L.Z = L.INCREMENT(L.U)

L.FIZZ     = L.UNSHIFT(L.UNSHIFT(L.UNSHIFT(L.UNSHIFT(L.EMPTY)(L.Z))(L.Z))(L.I))(L.F)
L.BUZZ     = L.UNSHIFT(L.UNSHIFT(L.UNSHIFT(L.UNSHIFT(L.EMPTY)(L.Z))(L.Z))(L.U))(L.B)
L.FIZZBUZZ = L.UNSHIFT(L.UNSHIFT(L.UNSHIFT(L.UNSHIFT(L.BUZZ)(L.Z))(L.Z))(L.I))(L.F)

L.TO_DIGITS = Z(function(f); return function(n)
  return L.PUSH(
    L.IF(L.IS_LESS_OR_EQUAL(n)(L.DECREMENT(L.TEN)))(
      L.EMPTY
    )(
      function(x); return f(L.DIV(n)(L.TEN))(x); end
    )
  )(L.MOD(n)(L.TEN))
end; end)

return L