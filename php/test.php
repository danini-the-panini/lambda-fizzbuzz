<?php
  include('lambda.php');

  function check($x) {
    if (!$x) {
      throw new ErrorException("check failed!");
    }
  }

  function checkEqual($e, $a) {
    if ($a != $e) {
      throw new ErrorException("expected " . $a . " to equal " . $e);
    }
  }

  checkEqual(0, toInteger($zero));
  checkEqual(1, toInteger($one));
  checkEqual(2, toInteger($two));
  checkEqual(3, toInteger($three));

  checkEqual(5, toInteger($five));
  checkEqual(10, toInteger($ten));
  checkEqual(15, toInteger($fifteen));
  checkEqual(100, toInteger($hundred));

  check(toBoolean($true));
  check(!toBoolean($false));

  checkEqual("a", $if($true)("a")("b"));
  checkEqual("b", $if($false)("a")("b"));

  check(toBoolean($isZero($zero)));
  check(!toBoolean($isZero($one)));

  checkEqual(1, toInteger($increment($zero)));
  checkEqual(2, toInteger($increment($one)));
  checkEqual(2, toInteger($decrement($three)));
  checkEqual(0, toInteger($decrement($zero)));

  checkEqual(8, toInteger($add($three)($five)));
  checkEqual(2, toInteger($subtract($five)($three)));
  checkEqual(0, toInteger($subtract($three)($five)));
  checkEqual(15, toInteger($multiply($three)($five)));
  checkEqual(125, toInteger($power($five)($three)));

  check(toBoolean($isLessOrEqual($three)($five)));
  check(toBoolean($isLessOrEqual($three)($three)));
  check(!toBoolean($isLessOrEqual($five)($three)));

  checkEqual(2, toInteger($mod($five)($three)));
  checkEqual(3, toInteger($mod($three)($five)));
  checkEqual(0, toInteger($mod($three)($three)));
  checkEqual(0, toInteger($mod($fifteen)($three)));
  checkEqual(0, toInteger($mod($fifteen)($five)));

  checkEqual(3, toInteger($div($fifteen)($five)));
  checkEqual(5, toInteger($div($fifteen)($three)));
  checkEqual(7, toInteger($div($fifteen)($two)));

  $list = $unshift($unshift($unshift($empty)($three))($two))($one);

  checkEqual(1, toInteger($first($list)));
  checkEqual(2, toInteger($first($rest($list))));
  checkEqual(3, toInteger($first($rest($rest($list)))));
  check(!toBoolean($isEmpty($list)));
  check(toBoolean($isEmpty($empty)));
  checkEqual([1, 2, 3], array_map('toInteger', $toArray($list)));

  checkEqual([1, 2, 3, 4, 5], array_map('toInteger', $toArray($range($one)($five))));
  checkEqual(15, toInteger($fold($range($one)($five))($zero)($add)));
  checkEqual(120, toInteger($fold($range($one)($five))($one)($multiply)));
  checkEqual([2, 3, 4, 5, 6], array_map('toInteger', $toArray($map($range($one)($five))($increment))));

  checkEqual('z', toChar($zed));
  checkEqual("FizzBuzz", $toString($fizzbuzz));

  checkEqual([5], array_map('toInteger', $toArray($toDigits($five))));
  checkEqual([1, 2, 5], array_map('toInteger', $toArray($toDigits($power($five)($three)))));

  checkEqual("5", $toString($toDigits($five)));
  checkEqual("125", $toString($toDigits($power($five)($three))));
?>