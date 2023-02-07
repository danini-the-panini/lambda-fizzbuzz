# Lambda FizzBuzz in PHP

```
λf.λx.f (f x)
```
⬇️
```php
function($f) { return function($x) use (&$f) { return $f($f($x)); }; };
```

## Prerequisites

1. [PHP](https://www.php.net/)

## Running

```
php main.php
```

To run tests:

```
php test.php
```
