defmodule AdventOfCode.Solutions.Year2024.Day9.Part1 do
  @moduledoc false

  @test_data """
  2333133121414131402
  """

  def parse_input(input) do
    input
    |> String.trim()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn
      {n, i} when rem(i, 2) == 0 ->
        List.duplicate(div(i, 2), n)

      {n, _} ->
        List.duplicate(:blank, n)
    end)
  end

  def compact(xs, cs \\ [])

  def compact([], cs), do: Enum.reverse(cs)

  def compact([:blank | tail], cs) do
    {v, rest} = List.pop_at(tail, -1)
    # IO.inspect(rest)

    if v == :blank do
      compact([:blank | rest], cs)
    else
      compact(rest, [v | cs])
    end
  end

  def compact([v | tail], cs) when is_integer(v), do: compact(tail, [v | cs])

  def solve(input) do
    input
    |> parse_input()
    |> compact()
    |> Enum.with_index()
    |> Enum.map(fn {x, i} -> x * i end)
    |> Enum.sum()
  end

  def test(), do: solve(@test_data)

  def start do
    case AdventOfCode.Input.get(__MODULE__) do
      {:ok, input} ->
        solve(input)
        |> IO.puts()

      {:error, reason} ->
        IO.puts("Error: #{reason}")
    end
  end
end
