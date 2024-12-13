defmodule AdventOfCode.Solutions.Year2024.Day13.Part2 do
  @moduledoc """
  Didn't come up with solution by myself.
  Watched https://www.youtube.com/watch?v=-5J-DAsWuJc for math explanation
  """

  @test_data """
  Button A: X+94, Y+34
  Button B: X+22, Y+67
  Prize: X=8400, Y=5400

  Button A: X+26, Y+66
  Button B: X+67, Y+21
  Prize: X=12748, Y=12176

  Button A: X+17, Y+86
  Button B: X+84, Y+37
  Prize: X=7870, Y=6450

  Button A: X+69, Y+23
  Button B: X+27, Y+71
  Prize: X=18641, Y=10279
  """

  @spec is_whole_number?(number()) :: boolean()
  def is_whole_number?(n) when is_integer(n), do: true
  def is_whole_number?(n), do: trunc(n) == n

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(fn block ->
      Regex.scan(~r/\d+/s, block)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2)
      |> then(fn [a, b, p] ->
        [
          a,
          b,
          p |> Enum.map(&(&1 + 10_000_000_000_000))
        ]
      end)
    end)
  end

  def solve(input) do
    input
    |> parse_input()
    |> Enum.map(fn [[ax, ay], [bx, by], [px, py]] ->
      ca = (px * by - py * bx) / (ax * by - ay * bx)
      cb = (px - ax * ca) / bx

      if is_whole_number?(ca) and is_whole_number?(cb) do
        ca * 3 + cb
      else
        0
      end
    end)
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
