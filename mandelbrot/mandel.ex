defmodule Mandel do
  
  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
      Cmplx.new(x + k * (w - 1), y - k * (h - 1))
      end 
    rows(width, height, trans, depth, [])
  end

  def rows(w, 0, trans, depth, listRows) do
    listRows
  end


  def rows(w, h, trans, depth, listRows) do
    row = row(w, h, trans, depth, [])
    rows(w, h - 1, trans, depth, [row | listRows])
  end

  def row(0, h, trans, depth, rowColors) do
    rowColors
  end
  
  def row(w, h, trans, depth, rowColors) do
    z = trans.(w, h)
    i = Brot.mandelbrot(z, depth)
    color = Colors.convert(i, depth)
    row(w - 1, h, trans, depth, [color | rowColors])
  end
end
