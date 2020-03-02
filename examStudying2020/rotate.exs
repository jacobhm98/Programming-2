defmodule Rotate do
  def rotate(list, l) do
    rotate([], list, l)
  end
  def rotate(l1, l2, 0) do
    Enum.concat(l2, Enum.reverse(l1))
  end

  def rotate(l1, [h|t], count) do
    rotate([h|l1], t, count - 1)
  end
end
