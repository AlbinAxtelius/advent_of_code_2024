defmodule AdventOfCode.Solutions.Year2024.Day13.Part1 do
  @moduledoc false
  import Nx.Defn

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

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(fn block ->
      Regex.scan(~r/\d+/s, block)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2)
      |> Enum.map(&Nx.tensor/1)
    end)
  end

  def solve(input) do
    input
    |> parse_input()
    |> Enum.map(fn [x, y, g] ->
      for a <- 0..100, b <- 0..100, Nx.add(Nx.multiply(a, x), Nx.multiply(b, y)) == g do
        Nx.tensor([a, b])
      end
    end)
    |> Enum.filter(&(&1 != []))
    |> List.flatten()
    |> Enum.map(&Nx.multiply(&1, Nx.tensor([3, 1])))
    |> Enum.flat_map(&Nx.to_flat_list/1)
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
