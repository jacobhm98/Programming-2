defmodule RedBlackTrees do
	
	def insertf(key, value, nil)do
		{:leaf, key, value}
	end

	def insertf(k, v, {:leaf, k1, _} = l) do
		cond do
			k <= k1 ->
				{:two, k , {:leaf, k, v}, l}

			true ->
				{:two, k1, l, {:leaf, k, v}}
		end
	end

	def insertf(k, v, {:two, k1, {:leaf, k1, _} = l1, {:leaf, k2, _} = l2}) do
		cond do
			k <= k1 ->
				{:three, k, k1, {:leaf, k, v}, l1, l2}

			k <= k2 ->
				{:three, k1, k, l1, {:leaf, k, v}, l2}

			true ->
				{:three, k1, k2, l1, l2, {:leaf, k, v}}
		end
	end
end