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
      :quit ->
        :ok
    end
  end

  def gone() do
    receive do
      :return -> available()
      :quit -> :ok
    end
  end
end
