defmodule Zip do

  def zip([], []) do
    []
  end

  def zip([h1|t1], [h2|t2]) do
    [{h1, h2}|zip(t1, t2)]
  end
end
