defmodule ExOrde24Test do
  use ExUnit.Case

  import ExOrde24

  test "0", do: assert solver("abc") == "abc"
end
