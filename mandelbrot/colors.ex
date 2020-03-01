defmodule Colors do
  def convert(d, m) do
    a = d/m *4
    x = trunc(a)
    y = 255 * (a - x)
    {78, y, 150}
  end
end
