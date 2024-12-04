defmodule AdventOfCode.Solutions.Year2024.Day4.Part2 do
  @moduledoc false

  @test_data """
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
  """

  def parse_input(input) do
    input |> String.trim() |> String.split("\n") |> Enum.map(&String.graphemes/1)
  end

  def find_mas(_, {0, _}), do: 0
  def find_mas(_, {_, 0}), do: 0

  def find_mas(grid, {x, y}) do
    cond do
      y >= Enum.count(grid) - 1 ->
        0

      x >= Enum.count(Enum.at(grid, 0)) - 1 ->
        0

      true ->
        rows =
          Enum.slice(grid, (y - 1)..(y + 1))
          |> Enum.map(&Enum.slice(&1, (x - 1)..(x + 1)))

        case rows do
          [
            ["M", _, "M"],
            [_, "A", _],
            ["S", _, "S"]
          ] ->
            1

          [
            ["S", _, "S"],
            [_, "A", _],
            ["M", _, "M"]
          ] ->
            1

          [
            ["M", _, "S"],
            [_, "A", _],
            ["M", _, "S"]
          ] ->
            1

          [
            ["S", _, "M"],
            [_, "A", _],
            ["S", _, "M"]
          ] ->
            1

          _ ->
            0
        end
    end
  end

  def solve(input) do
    grid = input |> parse_input()

    grid
    |> Enum.map(&Enum.with_index/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      Enum.map(row, fn
        {"A", x} -> {x, y}
        {_, _} -> nil
      end)
    end)
    |> Enum.filter(& &1)
    |> Enum.map(&find_mas(grid, &1))
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
