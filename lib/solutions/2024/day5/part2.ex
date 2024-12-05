defmodule AdventOfCode.Solutions.Year2024.Day5.Part2 do
  @moduledoc false

  @test_data """
  47|53
  97|13
  97|61
  97|47
  75|29
  61|13
  75|53
  29|13
  97|29
  53|29
  61|53
  97|53
  61|29
  47|13
  75|47
  97|75
  47|61
  75|61
  47|29
  75|13
  53|13

  75,47,61,53,29
  97,61,53,29,13
  75,29,13
  75,97,47,61,53
  61,13,29
  97,13,75,29,47
  """

  def parse_input(input) do
    [rules, items] = input |> String.trim() |> String.split("\n\n")

    rules_map =
      rules
      |> String.split("\n")
      |> Enum.map(fn r ->
        r
        |> String.split("|")
        |> List.to_tuple()
      end)
      |> Enum.group_by(&elem(&1, 1), &elem(&1, 0))

    item_rows = items |> String.split("\n") |> Enum.map(&String.split(&1, ","))

    {rules_map, item_rows}
  end

  def can_print_series?([], _, _), do: true

  def can_print_series?([c | rest], rules, printed) do
    pages_to_be_printed_before = MapSet.new(Map.get(rules, c, []))

    follows_rule? =
      MapSet.difference(pages_to_be_printed_before, printed) == MapSet.new()

    if follows_rule? do
      can_print_series?(rest, rules, MapSet.put(printed, c))
    else
      false
    end
  end

  def filter_rules_no_applicable(items, rules) do
    invalid_keys =
      MapSet.difference(MapSet.new(items), MapSet.new(Map.keys(rules))) |> MapSet.to_list()

    Map.drop(rules, invalid_keys)
    |> Map.to_list()
    |> Enum.map(fn {k, v} ->
      {k, v |> Enum.filter(&(&1 in items))}
    end)
    |> Enum.filter(fn {_, v} -> v != [] end)
    |> Enum.into(%{})
  end

  def sorter(a, b, rules) do
    a_rules = Map.get(rules, a)
    b_rules = Map.get(rules, b)

    cond do
      a_rules == nil -> true
      b_rules == nil -> false
      a in b_rules -> true
      b in a_rules -> false
    end
  end

  def solve(input) do
    {rules, items} =
      parse_input(input)

    items
    |> Enum.reduce([], fn x, acc ->
      r = filter_rules_no_applicable(x, rules)

      if not can_print_series?(x, r, %MapSet{}) do
        [Enum.sort(x, &sorter(&1, &2, r)) | acc]
      else
        acc
      end
    end)
    |> Enum.map(&Enum.at(&1, div(Enum.count(&1), 2)))
    |> Enum.map(&String.to_integer/1)
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
