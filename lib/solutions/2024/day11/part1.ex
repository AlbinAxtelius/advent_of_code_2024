defmodule AdventOfCode.Solutions.Year2024.Day11.Part1 do
  @moduledoc false

  @test_data """
  125 17
  """

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split(" ")
  end

  def blink(stones) do
    Enum.map(stones, fn stone ->
      is_even? = rem(String.length(stone), 2) == 0

      cond do
        is_even? ->
          String.split_at(stone, div(String.length(stone), 2))
          |> Tuple.to_list()
          |> Enum.map(&String.to_integer/1)
          |> Enum.map(&Integer.to_string/1)

        stone == "0" ->
          "1"

        true ->
          stone
          |> String.to_integer()
          |> (&(&1 * 2024)).()
          |> Integer.to_string()
      end
    end)
    |> List.flatten()
  end

  def solve(input) do
    Enum.reduce(0..24, parse_input(input), fn _, a -> blink(a) end) |> Enum.count()
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
