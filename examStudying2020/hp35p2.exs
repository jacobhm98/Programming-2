defmodule HP35P2 do

  def init() do
    wait()
  end

  def wait() do
    receive do
      {n1, from} -> receive do
        {n2, from} -> receive do
          {:add, from} ->
            add(n1, n2, from)
        end
      end
    end
  end

  def add(n1, n2, from) do
    send(n1+n2, from)
    wait()
  end
end
