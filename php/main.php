<?php
  include('lambda.php');

  $output = $map($range($one)($hundred))(function($n) use (&$if, &$isZero, &$mod, &$fifteen, &$fizzbuzz, &$three, &$fizz, &$five, &$buzz, &$toDigits) {
    return $if($isZero($mod($n)($fifteen)))(
      $fizzbuzz
    )($if($isZero($mod($n)($three)))(
      $fizz
    )($if($isZero($mod($n)($five)))(
      $buzz
    )(
      $toDigits($n)
    )));
  });

  foreach(array_map($toString, $toArray($output)) as &$value) {
    echo $value . "\n";
  }
?>