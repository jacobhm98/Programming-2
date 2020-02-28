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

	def drop([], _) do [] end

	def drop([h|t], {x, n}) do
		cond do
			rem(x,n) == 0 ->
				drop(t, {x+1, n})

			true -> [h|drop(t, {x+1, n})]
		end
	end

	def drop([h|t], n) do
		cond do
			n == 1 ->
				[]

			true ->
				[h|drop(t, {1, n})]
		end
	end

	def rot([h|t], 0) do
		append(t, reverse(h))
	end

	def rot([h|t], n) do
		l1 = [h|l]
		rot([l1|t], n-1)
	end

	

	

end