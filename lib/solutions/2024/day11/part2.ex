defmodule AdventOfCode.Solutions.Year2024.Day11.Part2 do
  @moduledoc false

  @test_data """
  125 17
  """

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split(" ")
    |> Enum.frequencies()
  end

  def handle_stone({stone, amount}) do
    cond do
      rem(String.length(stone), 2) == 0 ->
        String.split_at(stone, div(String.length(stone), 2))
        |> Tuple.to_list()
        |> Enum.map(&String.to_integer/1)
        |> Enum.map(&Integer.to_string/1)
        |> Enum.reduce(
          %{},
          fn x, acc ->
            Map.merge(
              acc,
              %{x => amount},
              fn _, v1, v2 -> v1 + v2 end
            )
          end
        )

      stone == "0" ->
        %{"1" => amount}

      true ->
        %{"#{String.to_integer(stone) * 2024}" => amount}
    end
  end

  def blink(stones) do
    stones
    |> Map.to_list()
    |> Enum.reduce(
      %{},
      fn x, acc ->
        Map.merge(
          acc,
          handle_stone(x),
          fn _, v1, v2 -> v1 + v2 end
        )
      end
    )
  end

  def solve(input) do
    input
    |> parse_input()
    |> (&Enum.reduce(1..75, &1, fn _, s -> blink(s) end)).()
    |> Map.to_list()
    |> Enum.map(fn {_, v} -> v end)
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
