defmodule AdventOfCode.Solutions.Day1.Part1 do
  @moduledoc false

  @test_data """
  """

  def parse_input(input) do
    input
  end

  def solve(input) do
    input |> parse_input()
  end

  def test(), do: solve(@test_data)

  def start do
    case AdventOfCode.Input.get(1) do
      {:ok, input} ->
        solve(input)
        |> IO.puts()

      {:error, reason} ->
        IO.puts("Error: #{reason}")
    end
  end
end
