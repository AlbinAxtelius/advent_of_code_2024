defmodule AdventOfCode.Solutions.Year2024.Day8.Part1 do
  @moduledoc false
  alias Helpers.GridHelpers

  @test_data """
  ............
  ........0...
  .....0......
  .......0....
  ....0.......
  ......A.....
  ............
  ............
  ........A...
  .........A..
  ............
  ............
  """

  def parse_input(input) do
    antennas_by_frequency =
      input
      |> String.trim()
      |> GridHelpers.to_coordinates()
      |> Map.filter(fn {_, v} -> v != "." end)
      |> Map.to_list()
      |> Enum.group_by(&elem(&1, 1), &elem(&1, 0))

    bounding_box =
      input
      |> String.trim()
      |> GridHelpers.get_bounding_box()

    {antennas_by_frequency, bounding_box}
  end

  def get_antinodes(antennas) do
    pairs = for x <- antennas, y <- antennas, x != y, do: [x, y]

    pairs
    |> Enum.flat_map(fn [{x1, y1}, {x2, y2}] ->
      delta_x = x1 - x2
      delta_y = y1 - y2

      [{x1 + delta_x, y1 + delta_y}]
    end)
    |> Enum.into(%MapSet{})
  end

  def solve(input) do
    {a, bb} =
      input
      |> parse_input()

    a
    |> Map.values()
    |> Enum.map(&get_antinodes/1)
    |> Enum.reduce(%MapSet{}, &MapSet.union/2)
    |> Enum.filter(&GridHelpers.is_inside_bounds?(&1, bb))
    |> Enum.count()
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
