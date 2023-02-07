# Lambda FizzBuzz in Lua

```
λf.λx.f (f x)
```
⬇️
```lua
function(f); return function(x); return f(f(x)); end; end
```

## Prerequisites

1. [Lua](https://www.lua.org/)

## Running

```
lua main.lua
```

To run tests:

```
lua test.lua
```
