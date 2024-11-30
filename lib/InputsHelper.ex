defmodule InputsHelper do
  @spec get_info_from_module(atom()) :: {integer(), integer()}
  def get_info_from_module(module) do
    [year_chunk, day_chunk, _] =
      module
      |> Atom.to_string()
      |> String.replace_leading("Elixir.AdventOfCode.Solutions.", "")
      |> String.split(".")

    {
      day_chunk |> String.replace("Day", "") |> String.to_integer(),
      year_chunk |> String.replace("Year", "") |> String.to_integer()
    }
  end
end
