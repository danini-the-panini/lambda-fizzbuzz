def to_integer(proc):
  return proc(lambda x: x + 1)(0)

def to_boolean(proc):
  return IF(proc)(True)(False)

def to_array(proc):
  array = []

  while not to_boolean(IS_EMPTY(proc)):
    array.append(FIRST(proc))
    proc = REST(proc)

  return array

def to_char(c):
  return '0123456789BFiuz'[to_integer(c)]

def to_string(s):
  return ''.join(to_char(x) for x in to_array(s))

ZERO  = lambda p: lambda x: x
ONE   = lambda p: lambda x: p(x)
TWO   = lambda p: lambda x: p(p(x))
THREE = lambda p: lambda x: p(p(p(x)))
FIVE  = lambda p: lambda x: p(p(p(p(p(x)))))

TRUE  = lambda x: lambda y: x
FALSE = lambda x: lambda y: y

IF = lambda b: b

IS_ZERO = lambda n: n(lambda x: FALSE)(TRUE)

INCREMENT = lambda n: lambda p: lambda x: p(n(p)(x))
DECREMENT = lambda n: lambda f: lambda x: n(lambda g: lambda h: h(g(f)))(lambda u: x)(lambda u: u)

ADD      = lambda m: lambda n: n(INCREMENT)(m)
SUBTRACT = lambda m: lambda n: n(DECREMENT)(m)
MULTIPLY = lambda m: lambda n: n(ADD(m))(ZERO)
POWER    = lambda m: lambda n: n(MULTIPLY(m))(ONE)

TEN     = ADD(FIVE)(FIVE)
FIFTEEN = ADD(TEN)(FIVE)
HUNDRED = MULTIPLY(TEN)(TEN)


IS_LESS_OR_EQUAL = lambda m: lambda n: IS_ZERO(SUBTRACT(m)(n))

Z = lambda f: (lambda x: f(lambda y: x(x)(y)))(lambda x: f(lambda y: x(x)(y)))

MOD = Z(lambda f: lambda m: lambda n:
  IF(IS_LESS_OR_EQUAL(n)(m))(
    lambda x: f(SUBTRACT(m)(n))(n)(x)
  )(
    m
  )
)

DIV = Z(lambda f: lambda m: lambda n:
  IF(IS_LESS_OR_EQUAL(n)(m))(
    lambda x: INCREMENT(f(SUBTRACT(m)(n))(n))(x)
  )(
    ZERO
  )
)

PAIR = lambda x: lambda y: lambda f: f(x)(y)
LEFT = lambda p: p(lambda x: lambda y: x)
RIGHT = lambda p: p(lambda x: lambda y: y)

EMPTY    = PAIR(TRUE)(TRUE)
UNSHIFT  = lambda l: lambda x: PAIR(FALSE)(PAIR(x)(l))
IS_EMPTY = LEFT
FIRST    = lambda l: LEFT(RIGHT(l))
REST     = lambda l: RIGHT(RIGHT(l))

RANGE = Z(lambda f: lambda m: lambda n:
  IF(IS_LESS_OR_EQUAL(m)(n))(
    lambda x: UNSHIFT(f(INCREMENT(m))(n))(m)(x)
  )(
    EMPTY
  )
)

FOLD = Z(lambda f: lambda l: lambda x: lambda g:
  IF(IS_EMPTY(l))(
    x
  )(
    lambda y: g(f(REST(l))(x)(g))(FIRST(l))(y)
  )
)

MAP = lambda k: lambda f: FOLD(k)(EMPTY)(lambda l: lambda x: UNSHIFT(l)(f(x)))

PUSH = lambda l: lambda x: FOLD(l)(UNSHIFT(EMPTY)(x))(UNSHIFT)

B = TEN
F   = INCREMENT(B)
I   = INCREMENT(F)
U   = INCREMENT(I)
ZED = INCREMENT(U)

FIZZ     = UNSHIFT(UNSHIFT(UNSHIFT(UNSHIFT(EMPTY)(ZED))(ZED))(I))(F)
BUZZ     = UNSHIFT(UNSHIFT(UNSHIFT(UNSHIFT(EMPTY)(ZED))(ZED))(U))(B)
FIZZBUZZ = UNSHIFT(UNSHIFT(UNSHIFT(UNSHIFT(BUZZ)(ZED))(ZED))(I))(F)

TO_DIGITS = Z(lambda f: lambda n:
  PUSH(
    IF(IS_LESS_OR_EQUAL(n)(DECREMENT(TEN)))(
      EMPTY
    )(
      lambda x: f(DIV(n)(TEN))(x)
    )
  )(MOD(n)(TEN))
)