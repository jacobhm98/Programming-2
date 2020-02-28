defmodule Brot do
  def mandelbrot(c,  m) do
    z0 = Cmplx.new(0, 0)
    i = 0
    test(i, z0, c, m)
  end

  def test(m, _, _, m)do
    0
  end

  def test(i, z, c, m) do
    magnitude = Cmplx.abs(z)
    cond do
      magnitude > 2 ->
        i
      magnitude <= 2 ->
        test(i + 1, Cmplx.add(Cmplx.sqr(z), c), c,  m)
    end
  end

end
