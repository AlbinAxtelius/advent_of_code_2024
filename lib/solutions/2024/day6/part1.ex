defmodule AdventOfCode.Solutions.Year2024.Day6.Part1 do
  @moduledoc false

  @test_data """
  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#...
  """

  def key_hash({x, y}), do: "#{x}_#{y}"

  def parse_input(input) do
    grid =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)

    notable_positions =
      grid
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, y} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn {value, x} -> {value, x, y} end)
      end)
      |> Enum.filter(fn
        {"#", _, _} -> true
        {"^", _, _} -> true
        {_, _, _} -> false
      end)

    %{"^" => [start_position], "#" => obstacles} =
      notable_positions |> Enum.group_by(&elem(&1, 0), &Tuple.delete_at(&1, 0))

    outer_edge =
      obstacles |> Enum.reduce({0, 0}, fn {x, y}, {cx, cy} -> {max(cx, x), max(cy, y)} end)

    {start_position, obstacles |> Enum.map(&key_hash/1) |> Enum.into(%MapSet{}), outer_edge}
  end

  def move(current, direction, obstacles, outer_edge, visited_positions)

  def move({x, y} = c, :up, os, oe, vs) do
    will_hit_obstacle? = MapSet.member?(os, key_hash({x, y - 1}))
    {_, _} = oe

    cond do
      will_hit_obstacle? -> move(c, :right, os, oe, MapSet.put(vs, key_hash(c)))
      y - 1 < 0 -> MapSet.put(vs, key_hash(c))
      true -> move({x, y - 1}, :up, os, oe, MapSet.put(vs, key_hash(c)))
    end
  end

  def move({x, y} = c, :down, os, oe, vs) do
    will_hit_obstacle? = MapSet.member?(os, key_hash({x, y + 1}))
    {_, oe_y} = oe

    cond do
      will_hit_obstacle? -> move(c, :left, os, oe, MapSet.put(vs, key_hash(c)))
      y + 1 > oe_y -> MapSet.put(vs, key_hash(c))
      true -> move({x, y + 1}, :down, os, oe, MapSet.put(vs, key_hash(c)))
    end
  end

  def move({x, y} = c, :right, os, oe, vs) do
    will_hit_obstacle? = MapSet.member?(os, key_hash({x + 1, y}))
    {oe_x, _} = oe

    cond do
      will_hit_obstacle? -> move(c, :down, os, oe, MapSet.put(vs, key_hash(c)))
      x + 1 > oe_x -> MapSet.put(vs, key_hash(c))
      true -> move({x + 1, y}, :right, os, oe, MapSet.put(vs, key_hash(c)))
    end
  end

  def move({x, y} = c, :left, os, oe, vs) do
    will_hit_obstacle? = MapSet.member?(os, key_hash({x - 1, y}))
    {_, _} = oe

    cond do
      will_hit_obstacle? -> move(c, :up, os, oe, MapSet.put(vs, key_hash(c)))
      x - 1 < 0 -> MapSet.put(vs, key_hash(c))
      true -> move({x - 1, y}, :left, os, oe, MapSet.put(vs, key_hash(c)))
    end
  end

  def solve(input) do
    {start_position, obstacles, outer_edge} = parse_input(input)

    move(start_position, :up, obstacles, outer_edge, %MapSet{}) |> MapSet.size()
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
