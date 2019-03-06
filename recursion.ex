defmodule Recursion do
	def binary(0), do: []

	def binary(m) do
	 binary(m/2) ++ [rem(m,2)]
	end
	

def fibonacci(0),  do: 0

def fibonacci(1), do: 1

def fibonacci(n) do
	fibonacci(n-1) + fibonacci(n-2)
end

end

defmodule ListOps do
	def drp([h|t])do
		[t]
	end

	def tak([h|t])do
		h
	end
	def append(l1, l2) do
		l1 ++ l2
	end
	def rev([h|[]]) do
		[h]
		
	end
	def rev([h|t]) do
		rev(t) ++ [h]
	end
end
