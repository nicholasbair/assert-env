defmodule Assert do
  @moduledoc """
  Assert the data type of environment variables at compile time
  """

  @doc ~S"""

  ## Examples

      iex> System.put_env("NOT_INT", "123")
      iex> Assert.init("./test/assertions/1_assertions.txt")
      ** (RuntimeError) Expected environment variable NOT_INT to be type float.

      iex> System.put_env("NOT_FLOAT", "1.23")
      iex> Assert.init("./test/assertions/2_assertions.txt")
      ** (RuntimeError) Expected environment variable NOT_FLOAT to be type integer.

      iex> System.put_env("NOT_STRING", "str")
      iex> Assert.init("./test/assertions/3_assertions.txt")
      ** (RuntimeError) Expected environment variable NOT_STRING to be type boolean.

      iex> System.put_env("NOT_BOOL", "true")
      iex> Assert.init("./test/assertions/4_assertions.txt")
      ** (RuntimeError) Expected environment variable NOT_BOOL to be type binary.

      iex> System.put_env("BOOL", "true")
      iex> Assert.init("./test/assertions/5_assertions.txt")
      :ok

      iex> System.put_env("JSON", "{\"key\": \"value\"}")
      iex> Assert.init("./test/assertions/6_assertions.txt")
      :ok

  """

  import Const

  @spec init(String.t) :: :ok
  def init(file \\ "assertions.txt"), do: get_file(file)

  # -- Private --
  @spec get_file(String.t) :: :ok
  defp get_file(file) do
    file
    |> File.stream!
    |> Stream.map(fn line -> parse_assertion(line) end)
    |> Stream.each(fn args -> assert(args) end)
    |> Stream.run
  end

  @spec parse_assertion(String.t) :: {String.t, String.t, String.t, String.t}
  defp parse_assertion(str) do
    str
    |> String.trim_trailing
    |> String.split(" ")
    |> List.to_tuple
  end

  @spec assert({String.t, String.t, String.t, String.t}) :: :ok
  defp assert({var, _is, "not", "nil"}), do: fetch!(var)
  defp assert({var, is, "type", "string"}), do: assert({var, is, "type", "binary"})
  defp assert({var, _is, "type", value}) do
    case apply(Kernel, "is_#{value}" |> String.to_atom(), [fetch!(var)]) do
      false -> raise "Expected environment variable #{var} to be type #{value}."
      true -> :ok
    end
  end

  defp assert(_), do: :ok

end
