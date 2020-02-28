defmodule Test do

	def double(n) do
	2 * n
	end
	def celsius(n) do
	(n-32)/1.8
	end

	def product(m, n) do
		if m == 0 do
			0
		else
			n + product(m-1, n)
		end
	end

	def product_case(m,n) do
	case m do
	0 ->
	0
	_ ->
	n + product_case(m-1, n)
	end
	end

	def exp(x, n) do
		case n do
			0 ->
			1
			_ ->
				product(x, exp(x, n-1))
		end
		
	end

	def len([])do
		0
	end
	def len([h|t]) do
		1 + len(t)
	end
	
	def add(x, l) do
		
	end
end
