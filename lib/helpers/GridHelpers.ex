defmodule Helpers.GridHelpers do
  def to_coordinates(str) do
    str
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      row
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {value, x} -> {{x, y}, value} end)
    end)
    |> Enum.into(%{})
  end

  def get_bounding_box(str) do
    rows = str |> String.split("\n")

    max_x = rows |> hd() |> String.length()
    max_y = rows |> Enum.count()

    {0, 0, max_x - 1, max_y - 1}
  end

  def is_inside_bounds?({x, y}, {min_x, min_y, max_x, max_y}),
    do: x >= min_x and x <= max_x and y >= min_y and y <= max_y
end
