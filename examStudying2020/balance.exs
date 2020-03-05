defmodule Balance do

  def balance({:node, _, left, right} = tree) do
    {max(depth(left, 0), depth(right, 0)), imbalance(tree)}
  end

  def depth(:nil, n) do
    n
  end

  def depth({:node, _, left, right}, n) do
    max(depth(left, n + 1), depth(right, n + 1))
  end

  def imbalance(:nil) do
    0
  end

  def imbalance({:node, _, left, right}) do
   max(max(imbalance(left), imbalance(right)), abs(depth(left, 0) - depth(right, 0)))
  end
end
