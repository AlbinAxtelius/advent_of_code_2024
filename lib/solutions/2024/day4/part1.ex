defmodule AdventOfCode.Solutions.Year2024.Day4.Part1 do
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

  def find_xmas(grid, {x, y}) do
    row = Enum.at(grid, y)

    right = Enum.slice(row, x..(x + 3))
    left = Enum.slice(row, (x - 3)..x)

    up =
      Enum.slice(grid, (y - 3)..y)
      |> Enum.map(&Enum.at(&1, x))

    down =
      Enum.slice(grid, y..(y + 3))
      |> Enum.map(&Enum.at(&1, x))

    diagonal_ne =
      0..3
      |> Enum.map(fn i ->
        y_index = y + i
        x_index = x + i

        cond do
          y_index < 0 ->
            []

          x_index < 0 ->
            []

          true ->
            case Enum.at(grid, y_index) do
              nil -> []
              e -> Enum.at(e, x_index)
            end
        end
      end)
      |> Enum.filter(& &1)

    diagonal_nw =
      0..3
      |> Enum.map(fn i ->
        y_index = y + i
        x_index = x - i

        cond do
          y_index < 0 ->
            []

          x_index < 0 ->
            []

          true ->
            case Enum.at(grid, y_index) do
              nil -> []
              e -> Enum.at(e, x_index)
            end
        end
      end)
      |> Enum.filter(& &1)

    diagonal_sw =
      0..3
      |> Enum.map(fn i ->
        y_index = y - i
        x_index = x - i

        cond do
          y_index < 0 ->
            []

          x_index < 0 ->
            []

          true ->
            case Enum.at(grid, y_index) do
              nil -> []
              e -> Enum.at(e, x_index)
            end
        end
      end)
      |> Enum.filter(& &1)

    diagonal_se =
      0..3
      |> Enum.map(fn i ->
        y_index = y - i
        x_index = x + i

        cond do
          y_index < 0 ->
            []

          x_index < 0 ->
            []

          true ->
            case Enum.at(grid, y_index) do
              nil -> []
              e -> Enum.at(e, x_index)
            end
        end
      end)
      |> Enum.filter(& &1)

    [
      right,
      left,
      up,
      down,
      diagonal_ne,
      diagonal_nw,
      diagonal_sw,
      diagonal_se
    ]
    |> Enum.map(&Enum.join(&1, ""))
    |> Enum.filter(fn
      "XMAS" -> true
      "SAMX" -> true
      _ -> false
    end)
    |> Enum.count()
  end

  def solve(input) do
    grid = input |> parse_input()

    grid
    |> Enum.map(&Enum.with_index/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      Enum.map(row, fn
        {"X", x} -> {x, y}
        {_, _} -> nil
      end)
    end)
    |> Enum.filter(& &1)
    |> Enum.map(&find_xmas(grid, &1))
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
