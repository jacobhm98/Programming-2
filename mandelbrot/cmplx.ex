defmodule Cmplx do
  
  def new(r, i) do
    {:cpx, r, i}
  end

  def add({:cpx, ar, ai}, {:cpx, br, bi}) do
    {:cpx, ar + br, ai + bi}
  end

  def sqr({:cpx, r, i}) do
    {:cpx, r*r - i*i, 2*r*i}
  end

  def abs({:cpx, r, i}) do
    :math.sqrt(r*r + i*i)
  end
end
