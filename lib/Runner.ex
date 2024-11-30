defmodule Runner do
  @spec run(non_neg_integer(), non_neg_integer(), non_neg_integer()) :: nil
  def run(day, part, year \\ DateTime.utc_now().year)

  def run(day, part, year) do
    solution_module =
      :"Elixir.AdventOfCode.Solutions.Year#{year}.Day#{day}.Part#{part}"

    apply(solution_module, :start, [])
  end

  @spec test(non_neg_integer(), non_neg_integer(), non_neg_integer()) :: nil
  def test(day, part, year \\ DateTime.utc_now().year)

  def test(day, part, year) do
    solution_module =
      :"Elixir.AdventOfCode.Solutions.Year#{year}.Day#{day}.Part#{part}"

    apply(solution_module, :test, [])
  end
end
