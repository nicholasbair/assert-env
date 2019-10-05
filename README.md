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
2. In `assertions.txt`, add your assertions

### Example Assertions
- SOME_VAR is not nil
- SOME_VAR is type float

### Provisions for Compile time
https://hexdocs.pm/mix/Mix.Task.Compiler.html
