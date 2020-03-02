defmodule HP35 do
  def hp35([h|t]) do
    hp35([h], t)
  end
  
  def hp35(res, []) do
    res
  end
  
  def hp35([n1|n2], [:add | t]) do
    hp35([n1 + n2], t)
  end
  
  def hp35([n1|n2], [:sub | t]) do
    hp35([n1 - n2], t)
  end
  
  def hp35([n1], [n2|t]) do
    hp35([n1|n2], t)
  end
end
