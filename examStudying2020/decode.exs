defmodule Decode do

  def decode(list) do
    decode(list, [])
  end

  def decode([], res) do
    res
  end
  
  def decode([h|t], res) do
    decode(t, res ++ expand(h))
  end
  
  def expand({_, 0}) do
    []
  end

  def expand({element, n}) do
    [element|expand({element, n - 1})]
  end
end
