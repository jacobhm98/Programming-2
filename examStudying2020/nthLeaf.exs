defmodule NthLeaf do

  def nth({:node, left, right}, n) do
    case nth(left, n) do
      {:found, val} -> {:found, val}
        
      {:cont, k}  -> 
        case nth(right, k) do
          {:found, val} -> {:found, val}
          {:cont, k} -> {:cont, k}
        end 
    end
  end
  def nth({:leaf, val}, 1) do
    {:found, val}
  end 
  def nth({:leaf, _}, n) do
    {:cont, n - 1}
  end
end
