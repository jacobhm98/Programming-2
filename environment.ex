defmodule Env do
	def new() do
		[]
	end

	def add(id, str, env) do
		env ++ [{id, str}]
	end

	def lookup(id, env) do
		
	end

	def remove(ids, env) do
		
	end
end