defmodule ExOrde24 do
  def solve(input) do
    [base, pos] = input |> String.split(",") |> Enum.map(&String.to_integer/1)

    base
    |> gen_and_at(pos)
    |> String.downcase()
  end

  def gen_and_at(base, pos) do
    gen_and_at(base, 1, pos)
  end

  def gen_and_at(base, length, pos) when pos < 1 or base <= length do
    "-"
  end

  def gen_and_at(base, length, pos) do
    series = gen(length, 1, base - 1, base)
    cond do
      Enum.count(series) < pos ->
        gen_and_at(base, length + 1, pos - Enum.count(series))
      true ->
        Enum.at(series, pos - 1)
    end
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
