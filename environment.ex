defmodule Env do
	def new() do
		[]
	end

	def add(id, str, env) do
		env ++ [{id, str}]
	end

	def lookup(id, [{id, str}|rest]) do
		[{id, str}|lookup(id, rest)]
	end

	def lookup(id, [_h|t]) do
		lookup(id, t)
	end

	def lookup(_id, []) do
		:nil
	end

	def remove(ids, env) do
		List.foldr(ids, env, 
			fn(id, env) -> List.keydelete(env, id, 0) end)
	end
end