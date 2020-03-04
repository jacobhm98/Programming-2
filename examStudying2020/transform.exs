defmodule Transform do

  def trans(:node, val :nil, :nil) do
    {:node, func.(val), :nil, :nil)
  end

  def trans({:node, val, :nil, right}, func) do
    {:node, func.(val), :nil, trans(right, func} 
  end

  def trans({:node, val, left, :nil}, func) do
    {:node, func.(val), trans(left, func), :nil}
  end

  def trans({:node, val, left, right}, func) do
    {:node, func.(val), trans(left, func), trans(right, func)}
  end

  def remit(tree, n) do
    func = fn(x) -> rem(x, n) end
    trans(tree, func)
  end
end
