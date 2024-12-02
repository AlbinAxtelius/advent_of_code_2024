defmodule AdventOfCode.Solutions.Year2024.Day2.Part2 do
  @moduledoc false

  @test_data """
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  """

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn x ->
      x
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @spec is_sorted?(list()) :: boolean()
  def is_sorted?(xs), do: Enum.sort(xs, :desc) == xs or Enum.sort(xs, :asc) == xs

  @spec is_safe_step?([integer()]) :: boolean()
  def is_safe_step?([_]), do: true

  def is_safe_step?([a, b | rest]) do
    step_size = abs(a - b)

    cond do
      step_size < 1 -> false
      step_size > 3 -> false
      true -> is_safe_step?([b | rest])
    end
  end

  @spec row_valid?([integer()]) :: boolean()
  def row_valid?(floor) do
    unless is_sorted?(floor) do
      false
    else
      is_safe_step?(floor)
    end
  end

  def get_permutations(xs) do
    xs
    |> Enum.with_index()
    |> Enum.map(fn {_, i} -> List.delete_at(xs, i) end)
  end

  def solve(input) do
    %{true => valid, false => invalid} =
      input
      |> parse_input()
      |> Enum.group_by(&row_valid?/1)

    initially_safe_floors = Enum.count(valid)

    floors_made_safe =
      invalid
      |> Enum.map(&get_permutations/1)
      |> Enum.filter(fn p ->
        Enum.any?(p, &row_valid?/1)
      end)
      |> Enum.count()

    initially_safe_floors + floors_made_safe
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
