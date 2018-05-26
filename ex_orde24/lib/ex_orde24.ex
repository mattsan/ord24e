defmodule ExOrde24.Memo do
  def start_link(_ \\ []) do
    Agent.start_link(fn -> Map.new() end, name: __MODULE__)
  end

  def size(min, max, n) when min > max or n > max, do: 0

  def size(min, max, 1), do: max - min + 1

  def size(min, max, n) do
    case Agent.get(__MODULE__, fn state -> state[{min, max, n}] end) do
      nil ->
        result =
          min..max - n + 1
          |> Enum.map(fn i ->
              size(i + 1, max, n - 1)
            end)
          |> Enum.sum()
        Agent.get_and_update(__MODULE__, fn state -> {result, Map.put(state, {min, max, n}, result)} end)
      value ->
        value
    end
  end
end

defmodule ExOrde24 do
  alias ExOrde24.Memo

  def solve(input) do
    [base, pos] = input |> String.split(",") |> Enum.map(&String.to_integer/1)

    find_pos = fn n, pos ->
      size = Memo.size(1, base - 1, n)
      cond do
        size < pos ->
          {:cont, pos - size}
        true ->
          {:halt, {pos, n}}
      end
    end

    case Enum.reduce_while(1..base - 1, pos, find_pos) do
      {pos, length} ->
        gen(length, 1, base - 1, base)
        |> Enum.at(pos - 1, "-")
        |> String.downcase()
      _ ->
        "-"
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
