<?php
function toInteger($proc) {
  return $proc(function($n) { return $n + 1; })(0);
}

function toBoolean($proc) {
  return $proc(true)(false);
}

$toArray = function($proc) use (&$isEmpty, &$first, &$rest) {
  $array = [];

  while (!toBoolean($isEmpty($proc))) {
    $array[] = $first($proc);
    $proc = $rest($proc);
  }

  return $array;
};

function toChar($c) {
  return "0123456789BFiuz"[toInteger($c)];
}

$toString = function($s) use (&$toArray) {
  return implode('', array_map('toChar', $toArray($s)));
};

$zero  = function($p) { return function($x) { return $x; }; };
$one   = function($p) { return function($x) use (&$p) { return $p($x); }; };
$two   = function($p) { return function($x) use (&$p) { return $p($p($x)); }; };
$three = function($p) { return function($x) use (&$p) { return $p($p($p($x))); }; };

$five    = function($p) { return function($x) use (&$p) { return $p($p($p($p($p($x))))); }; };
$ten     = function($p) { return function($x) use (&$p) { return $p($p($p($p($p($p($p($p($p($p($x)))))))))); }; };
$fifteen = function($p) { return function($x) use (&$p) { return $p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($x))))))))))))))); }; };
$hundred = function($p) { return function($x) use (&$p) { return $p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($p($x)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))); }; };

$true  = function($x) { return function($y) use (&$x) { return $x; }; };
$false = function($x) { return function($y) { return $y; }; };

$if = function($b) { return $b; };

$isZero = function($n) use (&$true, &$false) { return $n(function($x) use (&$false) { return $false; })($true); };

$increment = function($n) { return function($p) use (&$n) { return function($x) use (&$n, &$p) { return $p($n($p)($x)); }; }; };
$decrement = function($n) { return function($f) use (&$n) { return function($x) use (&$f, &$n) {
  return $n(function($g) use (&$f) { return function($h) use (&$f, &$g) { return $h($g($f)); }; })(function($u) use (&$x) { return $x; })(function($u) { return $u; });
}; }; };

$add      = function($m) use (&$increment)       { return function($n) use (&$increment, &$m)       { return $n($increment)($m); }; };
$subtract = function($m) use (&$decrement)       { return function($n) use (&$decrement, &$m)       { return $n($decrement)($m); }; };
$multiply = function($m) use (&$add, &$zero)     { return function($n) use (&$add, &$zero, &$m)     { return $n($add($m))($zero); }; };
$power    = function($m) use (&$multiply, &$one) { return function($n) use (&$multiply, &$one, &$m) { return $n($multiply($m))($one); }; };

$isLessOrEqual = function($m) use (&$isZero, &$subtract) { return function($n) use (&$isZero, &$subtract, &$m) {
  return $isZero($subtract($m)($n));
}; };

$z = function($f) {
  return (function($x) use (&$f) {
    return $f(function($y) use (&$x) { return $x($x)($y); });
  })(function($x) use (&$f) {
    return $f(function($y) use (&$x) { return $x($x)($y); });
  });
};

$mod = $z(function($f) use (&$if, &$isLessOrEqual, &$subtract) { return function($m) use (&$if, &$isLessOrEqual, &$subtract, &$f) { return function($n) use (&$if, &$isLessOrEqual, &$subtract, &$f, &$m) {
  return $if($isLessOrEqual($n)($m))(
    function($x) use (&$subtract, $f, &$m, &$n) { return $f($subtract($m)($n))($n)($x); }
  )(
    $m
  );
}; }; });

$div = $z(function($f) use (&$if, &$isLessOrEqual, &$increment, &$subtract, &$zero) { return function($m) use (&$if, &$isLessOrEqual, &$increment, &$subtract, &$zero, &$f) { return function($n) use (&$if, &$isLessOrEqual, &$increment, &$subtract, &$zero, &$f, &$m) {
  return $if($isLessOrEqual($n)($m))(
    function($x) use (&$increment, &$subtract, &$f, &$m, &$n) { return $increment($f($subtract($m)($n))($n))($x); }
  )(
    $zero
  );
}; }; });

$pair  = function($x) { return function($y) use (&$x) { return function($f) use (&$x, &$y) { return $f($x)($y); }; }; };
$left  = function($p) { return $p(function($x) { return function($y) use (&$x) { return $x; }; }); };
$right = function($p) { return $p(function($x) { return function($y) { return $y; }; }); };

$empty   = $pair($true)($true);
$unshift = function($l) use (&$pair, &$false) { return function($x) use (&$pair, &$false, &$l) { return $pair($false)($pair($x)($l)); }; };
$isEmpty = $left;
$first   = function($l) use (&$left, &$right) { return $left($right($l)); };
$rest    = function($l) use (&$right) { return $right($right($l)); };

$range = $z(function($f) use (&$if, &$isLessOrEqual, &$unshift, &$increment, &$empty) { return function($m) use (&$if, &$isLessOrEqual, &$unshift, &$increment, &$empty, &$f) { return function($n) use (&$if, &$isLessOrEqual, &$unshift, &$increment, &$empty, &$f, &$m) {
  return $if($isLessOrEqual($m)($n))(
    function($x) use (&$unshift, &$increment, &$f, &$m, &$n) { return $unshift($f($increment($m))($n))($m)($x); }
  )(
    $empty
  );
}; }; });

$fold = $z(function($f) use (&$if, &$isEmpty, &$rest, &$first) { return function($l) use (&$if, &$isEmpty, &$rest, &$first, &$f) { return function($x) use (&$if, &$isEmpty, &$rest, &$first, &$f, &$l) { return function($g) use (&$if, &$isEmpty, &$rest, &$first, &$f, &$l, &$x) {
  return $if($isEmpty($l))(
    $x
  )(
    function($y) use (&$rest, &$first, &$f, &$l, &$x, &$g) { return $g($f($rest($l))($x)($g))($first($l))($y); }
  );
}; }; }; });

$map = function($k) use (&$fold, &$empty, &$unshift) { return function($f) use (&$fold, &$empty, &$unshift, &$k) {
  return $fold($k)($empty)(
    function($l) use (&$unshift, &$f) { return function($x) use (&$unshift, &$f, &$l) { return $unshift($l)($f($x)); }; }
  );
}; };

$push = function($l) use (&$fold, &$unshift, &$empty) { return function($x) use (&$fold, &$unshift, &$empty, &$l) {
  return $fold($l)($unshift($empty)($x))($unshift);
}; };

$b   = $ten;
$f   = $increment($b);
$i   = $increment($f);
$u   = $increment($i);
$zed = $increment($u);

$fizz     = $unshift($unshift($unshift($unshift($empty)($zed))($zed))($i))($f);
$buzz     = $unshift($unshift($unshift($unshift($empty)($zed))($zed))($u))($b);
$fizzbuzz = $unshift($unshift($unshift($unshift($buzz)($zed))($zed))($i))($f);

$toDigits = $z(function($f) use (&$push, &$if, &$isLessOrEqual, &$decrement, &$ten, &$empty, &$div, &$mod) {
  return function($n) use (&$push, &$if, &$isLessOrEqual, &$decrement, &$ten, &$empty, &$div, &$mod, &$f) {
    return $push(
      $if($isLessOrEqual($n)($decrement($ten)))(
        $empty
      )(
        function($x) use(&$div, &$ten, &$f, &$n) {
          return $f($div($n)($ten))($x);
        }
      )
    )($mod($n)($ten));
  };
});
?>
