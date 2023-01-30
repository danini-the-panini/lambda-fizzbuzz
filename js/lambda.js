export function toInteger(proc) {
  return proc(n => n + 1)(0);
}

export function toBoolean(proc) {
  return IF(proc)(true)(false);
}

export function toArray(proc) {
  let array = [];

  while (!toBoolean(IS_EMPTY(proc))) {
    array.push(FIRST(proc));
    proc = REST(proc);
  }

  return array;
}

export function toChar(c) {
  return '0123456789BFiuz'[toInteger(c)];
}

export function toString(s) {
  return toArray(s).map(toChar).join('');
}

export const ZERO  = p => x => x;
export const ONE   = p => x => p(x);
export const TWO   = p => x => p(p(x));
export const THREE = p => x => p(p(p(x)));

export const FIVE    = p => x => p(p(p(p(p(x)))));
export const TEN     = p => x => p(p(p(p(p(p(p(p(p(p(x))))))))));
export const FIFTEEN = p => x => p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(x)))))))))))))));
export const HUNDRED = p => x => p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(p(x))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));

export const TRUE  = x => y => x;
export const FALSE = x => y => y;

export const IF = b => b;

export const IS_ZERO = n => n(x => FALSE)(TRUE);

export const INCREMENT = n => p => x => p(n(p)(x));
export const DECREMENT = n => f => x => n(g => h => h(g(f)))(u => x)(u => u)

export const ADD      = m => n => n(INCREMENT)(m);
export const SUBTRACT = m => n => n(DECREMENT)(m);
export const MULTIPLY = m => n => n(ADD(m))(ZERO);
export const POWER    = m => n => n(MULTIPLY(m))(ONE);

export const IS_LESS_OR_EQUAL = m => n => IS_ZERO(SUBTRACT(m)(n));

export const Z = f => (x => f(y => x(x)(y)))(x => f(y => x(x)(y)));

export const MOD = Z(f => m => n =>
  IF(IS_LESS_OR_EQUAL(n)(m))(
    x => f(SUBTRACT(m)(n))(n)(x)
  )(
    m
  )
);

export const DIV = Z(f => m => n =>
  IF(IS_LESS_OR_EQUAL(n)(m))(
    x => INCREMENT(f(SUBTRACT(m)(n))(n))(x)
  )(
    ZERO
  )
);

export const PAIR  = x => y => f => f(x)(y);
export const LEFT  = p => p(x => y => x);
export const RIGHT = p => p(x => y => y);

export const EMPTY    = PAIR(TRUE)(TRUE);
export const UNSHIFT  = l => x => PAIR(FALSE)(PAIR(x)(l));
export const IS_EMPTY = LEFT
export const FIRST    = l => LEFT(RIGHT(l));
export const REST     = l => RIGHT(RIGHT(l));

export const RANGE = Z(f => m => n =>
  IF(IS_LESS_OR_EQUAL(m)(n))(
    x => UNSHIFT(f(INCREMENT(m))(n))(m)(x)
  )(
    EMPTY
  )
);

export const FOLD = Z(f => l => x => g =>
  IF(IS_EMPTY(l))(
    x
  )(
    y => g(f(REST(l))(x)(g))(FIRST(l))(y)
  )
);

export const MAP = k => f =>
  FOLD(k)(EMPTY)(
    l => x => UNSHIFT(l)(f(x))
  );

export const PUSH = l => x => FOLD(l)(UNSHIFT(EMPTY)(x))(UNSHIFT);

export const B   = TEN;
export const F   = INCREMENT(B);
export const I   = INCREMENT(F);
export const U   = INCREMENT(I);
export const ZED = INCREMENT(U);

export const FIZZ     = UNSHIFT(UNSHIFT(UNSHIFT(UNSHIFT(EMPTY)(ZED))(ZED))(I))(F);
export const BUZZ     = UNSHIFT(UNSHIFT(UNSHIFT(UNSHIFT(EMPTY)(ZED))(ZED))(U))(B);
export const FIZZBUZZ = UNSHIFT(UNSHIFT(UNSHIFT(UNSHIFT(BUZZ)(ZED))(ZED))(I))(F);

export const TO_DIGITS = Z(f => n =>
  PUSH(
    IF(IS_LESS_OR_EQUAL(n)(DECREMENT(TEN)))(
      EMPTY
    )(
      x => f(DIV(n)(TEN))(x)
    )
  )(MOD(n)(TEN))
);