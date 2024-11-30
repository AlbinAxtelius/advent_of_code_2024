defmodule Runner do
  @spec run(non_neg_integer(), non_neg_integer(), non_neg_integer()) :: nil
  def run(day, part, year \\ DateTime.utc_now().year)

  def run(day, part, year) do
    solution_module =
      :"Elixir.AdventOfCode.Solutions.Year#{year}.Day#{day}.Part#{part}"

    apply(solution_module, :start, [])
  end
end
