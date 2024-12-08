defmodule AdventOfCode.Solutions.Year2024.Day8.Part2 do
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

  def get_nodes({x1, y1}, {x2, y2}, bounding_box, acc) do
    x = x1 + x1 - x2
    y = y1 + y1 - y2

    if GridHelpers.is_inside_bounds?({x, y}, bounding_box) do
      get_nodes({x, y}, {x1, y1}, bounding_box, [{x, y} | acc])
    else
      acc
    end
  end

  def get_antinodes(antennas, bounding_box) do
    pairs = for x <- antennas, y <- antennas, x != y, do: [x, y]

    pairs
    |> Enum.flat_map(fn [p1, p2] ->
      get_nodes(p1, p2, bounding_box, [p1, p2])
    end)
    |> Enum.into(%MapSet{})
  end

  def solve(input) do
    {a, bb} =
      input
      |> parse_input()

    a
    |> Map.values()
    |> Enum.map(&get_antinodes(&1, bb))
    |> Enum.reduce(%MapSet{}, &MapSet.union/2)
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
