defmodule AdventOfCode.Solutions.Year2024.Day1.Part1 do
  @moduledoc false

  @test_data """
  3   4
  4   3
  2   5
  1   3
  3   9
  3   3\
  """

  def parse_input(input) do
    {lx, rx} =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn x ->
        x
        |> String.split("   ")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
      |> Enum.unzip()

    {Enum.sort(rx), Enum.sort(lx)}
  end

  def solve(input) do
    input
    |> parse_input()
    |> Tuple.to_list()
    |> Enum.zip_reduce(0, fn [l, r], acc -> acc + abs(l - r) end)
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
