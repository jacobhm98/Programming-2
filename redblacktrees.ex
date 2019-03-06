defmodule RedBlackTrees do
	@moduledoc """
	This is an unfinished module for creating red black trees. It currently handles the insert operation
	with null trees, leaves, two nodes consisting of leaves, and three nodes consisting of leaves. May be finished
	later, however was done as a form of exam studying. So don't count on it.
	"""
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

	def insertf(k, v, {:three, k1, k2, {:leaf, k1, _} = l1, {:leaf, k2, _} = l2, {:leaf, k3, _} = l3}) do
		cond do
			k <= k1 ->
				{:four, k, k1, k2, {:leaf, k, v}, l1, l2, l3}

			k <= k2 ->
				{:four, k1, k, k2, l1, {:leaf, k, v}}
		end

	end
end