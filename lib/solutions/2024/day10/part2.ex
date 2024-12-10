defmodule AdventOfCode.Solutions.Year2024.Day10.Part2 do
  @moduledoc false
  alias Helpers.GridHelpers

  @test_data """
  89010123
  78121874
  87430965
  96549874
  45678903
  32019012
  01329801
  10456732
  """

  def parse_input(input) do
    input
    |> String.trim()
    |> GridHelpers.to_coordinates(fn
      "." -> -1
      x -> String.to_integer(x)
    end)
  end

  def traverse(pos, grid) do
    value =
      grid[pos]

    value_to_find = value + 1

    {x, y} = pos

    valid_surrounding =
      [
        {x, y - 1},
        {x - 1, y},
        {x + 1, y},
        {x, y + 1}
      ]
      |> Enum.filter(&(Map.get(grid, &1) == value_to_find))

    cond do
      value == 9 -> [pos]
      valid_surrounding == [] -> []
      true -> Enum.flat_map(valid_surrounding, &traverse(&1, grid))
    end
  end

  def solve(input) do
    grid =
      input
      |> parse_input()

    grid
    |> Map.to_list()
    |> Enum.filter(fn {_, v} -> v == 0 end)
    |> Enum.map(fn {pos, _} ->
      pos
      |> traverse(grid)
      |> Enum.count()
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
