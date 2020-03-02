defmodule Philosopher do
  def start(hunger, strength, right, left, name, ctrl, seed) do
    spawn_link(Philosopher, :atTable, [hunger, strength, right, left, name, ctrl, seed])
  end

  def atTable(hunger, strength, right, left, name, ctrl, seed) do
    IO.puts("#{name} has sat down at the table")
    sleep(seed)
    eat(hunger, strength, right, left, name, ctrl, seed)
  end

  def sleep(seed) do
    :timer.sleep(:rand.uniform(seed))
  end

  def eat(hunger, strength, right, left, name, ctrl, seed) do
    Chopstick.request(right)
    IO.puts("#{name} has received the right chopstick")
    Chopstick.request(left)
    IO.puts("#{name} has received the left chopstick")
    sleep(seed)
    IO.puts("#{name} is done eating")
    Chopstick.return(right)
    Chopstick.return(left)
    IO.puts("#{name} has returned the chopsticks")
    send(ctrl, :done)
    atTable(hunger, strength, right, left, name, ctrl, seed)
  end
end
