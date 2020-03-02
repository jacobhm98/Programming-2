defmodule Drop do
  def drop([], _, _) do
    []
  end
  
  def drop([h|t], 1, n) do
   drop(t, n, n)
  end
  def drop([h|t], a, n) do
    [h|drop(t, a - 1, n)]
  end
  def drop(list, n) do
   drop(list, n, n) 
  end
end
