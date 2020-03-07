defmodule Gray do

  def gray(0) do
    [[]]
  end

  def gray(n) do
    lower = gray(n - 1)
    upper = Enum.reverse(lower)
    update(lower, 0) ++ update(upper, 1)
  end

  def update([], _) do
    []
  end

  def update([h|t], num) do
    [[num|h]|update(t, num)]
  end
end
