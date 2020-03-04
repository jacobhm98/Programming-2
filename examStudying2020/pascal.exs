defmodule Pascal do
  def pascal(n) do
    pascal([1], n - 1)
  end

  def pascal(currentRow, 0) do
    currentRow
  end
  
  def pascal(currentRow, n) do
    pascal(nextRow(currentRow), n - 1)
  end
  
  def nextRow([1]) do
    [1, 1]
  end
  
  def nextRow(currentRow) do
    nextRow(currentRow, [])
  end
  
  def nextRow([n1|[]], next) do
    [1] ++ next ++ [1]
  end
  
  def nextRow([n1, n2|t], next) do
    nextRow([n2|t], [n1 + n2|next])
  end  
end
