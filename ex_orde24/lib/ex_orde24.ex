defmodule ExOrde24 do
  def solve(input) do
    [base, pos] = input |> String.split(",") |> Enum.map(&String.to_integer/1)

    result =
      base
      |> gen()
      |> Enum.at(pos - 1, "-")
      |> String.downcase()

    IO.puts "\n#{input} => #{result}"

    result
  end

  def gen(base) do
    1..base-1
    |> Enum.flat_map(&gen(&1, 1, base - 1, base))
  end

  def gen(1, min, max, base) do
    min..max |> Enum.map(&Integer.to_string(&1, base))
  end

  def gen(length, min, max, base) do
    min .. (max + 1 - length)
    |> Enum.flat_map(fn x ->
        gen(length - 1, x + 1, max, base)
        |> Enum.map(fn xs ->
            Integer.to_string(x, base) <> xs
          end)
      end)
  end
end
