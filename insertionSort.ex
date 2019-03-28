defmodule InsertionSort do
  @moduledoc """
  Sorting function implemented for huffman coding. Sorting lists of tuples of form {_, integer}.
  Implemented using the insertion sort algorithm, sorted by size of integer in ascending order.
  """

def sort(list) do sort(list, []) end

  #base case, if we have an empty list of unsorted elements, return sorted elements
  def sort([], sortedList) do
    sortedList
  end

  def sort([head | tail], sortedList) do
  	sort(tail, sortf(head, sortedList))
  end

#helper function that inserts the element in question in the right place of the sorted list
  def sortf(x, []) do
  	[x]
  end

  def sortf(({_, freq} = element), [({_, compFreq}) = head | rest]) when freq > compFreq do
    [head | sortf(element, rest)]
  end

  def sortf(element, sortedList) do
    [element|sortedList]
  end
end