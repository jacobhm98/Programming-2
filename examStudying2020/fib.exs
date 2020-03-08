defmodule Fib do

  def fib() do
    fn -> (fib(1, 0) end)
  end
  
  def fib(n1, n2) do
    {:ok, n1, fn -> fib(n1 + n2, n1) end}
  end

end
