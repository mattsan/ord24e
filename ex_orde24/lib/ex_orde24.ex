defmodule ExOrde24 do
  def solve(input) do
    [base, pos] =
      input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    case [0] |> Stream.unfold(&{&1, inc(&1, base)}) |> Enum.at(pos) do
      nil ->
        "-"
      value ->
        value
        |> Enum.reverse()
        |> Enum.map(& &1 |> Integer.to_string(base) |> String.downcase())
        |> Enum.join()
    end
  end

  def inc(nil, _), do: nil

  def inc([1], 2), do: nil

  def inc([n], base) when n + 1 == base, do: [2, 1]

  def inc([d | ds], base) when d + 1 == base do
    max_figure = base - 1
    case inc(ds, base - 1) do
      nil ->
        nil
      [^max_figure | _] ->
        nil
      [d | _] = value ->
        [d + 1 | value]
    end
  end

  def inc([d | ds], _), do: [d + 1 | ds]
end
