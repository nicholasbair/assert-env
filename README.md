# Assert

Assert the type of a environment variable at compile time.

## Installation

```elixir
def deps do
  [
    {:assert, git: "https://github.com/nicholasbair/assert-env.git"}
  ]
end
```

## Usage
1. Add a file to project root, `assertions.txt`
2. In `assertions.txt`, add your assertions (one per line, no empty lines)

### Supported Assertions
- SOME_VAR is not nil
- SOME_VAR is type float
- SOME_VAR is type integer
- SOME_VAR is type string
- SOME_VAR is type boolean

### Provisions for Compile time
Run assertions at compile time (cause the build to fail without the correct environment variables) by adding a module:
```elixir
defmodule MyModule.Assert do
  Assert.init()
end
```
