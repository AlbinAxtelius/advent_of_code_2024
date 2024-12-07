defmodule AdventOfCode.Solutions.Year2024.Day7.Part2 do
  @moduledoc false

  @test_data """
  190: 10 19
  3267: 81 40 27
  83: 17 5
  156: 15 6
  7290: 6 8 6 15
  161011: 16 10 13
  192: 17 8 14
  21037: 9 7 18 13
  292: 11 6 16 20
  """

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn x ->
      [total, parts] = x |> String.split(": ")

      {
        String.to_integer(total),
        parts
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)
      }
    end)
  end

  def can_become?(input, index \\ 0) do
    {base, instructions} = input
    [start | rest] = instructions

    terms =
      Integer.to_string(index, 3)
      |> String.pad_leading(Enum.count(rest), "0")
      |> String.graphemes()
      |> Enum.map(fn
        "0" -> :add
        "1" -> :mul
        "2" -> :con
      end)

    result =
      rest
      |> Enum.zip(terms)
      |> Enum.reduce(start, fn
        {c, :add}, a -> a + c
        {c, :mul}, a -> a * c
        {c, :con}, a -> String.to_integer("#{a}#{c}")
      end)

    cond do
      result == base ->
        true

      Enum.count(terms) > Enum.count(rest) ->
        false

      true ->
        can_become?(input, index + 1)
    end
  end

  def solve(input) do
    input
    |> parse_input()
    |> Enum.filter(&can_become?(&1, 0))
    |> Enum.map(&elem(&1, 0))
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
