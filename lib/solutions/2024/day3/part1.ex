defmodule AdventOfCode.Solutions.Year2024.Day3.Part1 do
  @moduledoc false

  @test_data """
  xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
  """

  def parse_input(input) do
    regex = ~r/(mul)\((\d+),(\d+)\)/

    input
    |> String.trim()
    |> (&Regex.scan(regex, &1)).()
    |> Enum.map(fn [_, action, a, b] -> {action, String.to_integer(a), String.to_integer(b)} end)
  end

  def solve(input) do
    input |> parse_input() |> Enum.reduce(0, fn {"mul", a, b}, acc -> acc + a * b end)
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
