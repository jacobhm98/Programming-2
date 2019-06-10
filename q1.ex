defmodule Q1 do

	def decode(tuplelist) do
		decode(tuplelist, [])
	end

	def decode([], list) do list end

	def decode([h|t], []) do
		decode(t, list(h))
	end

	def decode([h|t], finishedList) do
		decode(t, finishedList ++ list(h))
	end

	def list({atom, freq}) do
		list({atom, freq - 1} [atom])
	end

	def list({_, 0}, tempList) do
		tempList
	end

	def list({atom, freq}, tempList) do
		list({atom, freq - 1}, tempList ++ [atom])
	end

end