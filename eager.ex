defmodule Eager do
	def eval_expr({:atm, id}, env) do 
		{:ok, id}
	end

	def eval_expr({:var, id}, env) do
  	case Env.lookup(id, env) do
    	nil -> :error

    	{_, str} ->
	      {:ok, str}
	  end
	end

	def eval_expr({:cons, head, tail}, env) do
	  case eval_expr(head, env) do
	    :error ->
	      :error
	    {:ok, hs} ->
	      case eval_expr({:cons, tail}, env) do
	        :error ->
	          :error
	        {:ok, ts} ->
	          {:ok, [hs|ts]}
	      end
	  end
	end
end