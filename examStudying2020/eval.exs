defmodule Eval do

  def eval({:add, expr1, expr2}) do
    eval(expr1) + eval(expr2)
  end

  def eval({:mul, expr1, expr2}) do
    eval(expr1) * eval(expr2)
  end

  def eval({:neg, expr}) do
    -eval(expr)
  end

  def eval(num) do
    num
  end
end
