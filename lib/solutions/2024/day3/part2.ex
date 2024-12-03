defmodule AdventOfCode.Solutions.Year2024.Day3.Part2 do
  @moduledoc false

  @test_data """
  xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
  """

  def parse_input(input) do
    regex = ~r/(mul\([\d,]+\)|do?n't\(\)|do\(\))/

    input
    |> String.trim()
    |> (&Regex.scan(regex, &1)).()
    |> Enum.map(fn
      [_, "do()"] ->
        {"do", nil, nil}

      [_, "don't()"] ->
        {"don't", nil, nil}

      [_, action] ->
        [[_, a, b]] = Regex.scan(~r/\((\d+),(\d+)\)/, action)

        {"mul", String.to_integer(a), String.to_integer(b)}
    end)
  end

  def solve(input) do
    input
    |> parse_input()
    |> Enum.reduce({0, true}, fn
      {"mul", a, b}, {n, true} -> {n + a * b, true}
      {"mul", _, _}, {_, false} = acc -> acc
      {"do", _, _}, {n, _} -> {n, true}
      {"don't", _, _}, {n, _} -> {n, false}
    end)
    |> elem(0)
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
