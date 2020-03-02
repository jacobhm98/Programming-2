defmodule Chopstick do

  def start do
    stickID = spawn_link(fn -> available() end)
    stickID
  end

  def available() do
    receive do
      {:request, from} ->
        send(from, {:granted, self()})
        gone()
      :quit -> :ok
    end
  end

  def gone() do
    receive do
      {:return, from} ->
        send(from, {:returned, self()})
        available()
      :quit -> :ok
    end
  end

  def request(stick) do
    send(stick, {:request, self()})
    receive do
      {:granted, _} -> :ok
    end
  end

  def return(stick) do
    send(stick, {:return, self()})
    receive do
      {:returned, _} -> :ok
    end
  end
  def quit(stick) do
    send(stick, :quit)
  end

end
