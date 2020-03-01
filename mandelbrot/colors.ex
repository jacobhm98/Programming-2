defmodule Colors do
  def convert(d, m) do
    a = d/m *4
    x = trunc(a)
    y = trunc(255 * (a - x))
    {:rgb, 0, y, 255}
  end
end
