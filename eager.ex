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

	def eval_match(:ignore, _, env) do
		{:ok, env}
	end

	def eval_match({:atm, id}, id, env) do
		{:ok, env}
	end

	def eval_match({:var, id}, str, env) do
		case Env.lookup(id, env) do
			nil ->
				{:ok, Env.add(id, str, env)}
			{_, ^str} ->
				{:ok, env}
			{_, _} ->
				:fail
		end
	end

	def eval_match({:cons, hp, tp}, [hs|ts], env) do
		case eval_match(hp, hs, env) do
			:fail ->
				:fail
			{:ok, _} ->
				eval_match(tp, ts, env)
		end
	end

	def eval_match(_, _, _) do
		:fail
	end

	def eval_seq([exp], env) do
  		eval_expr(exp, env)
	end

	def eval_seq([{:match, id1, str1} | rest], env) do
		case eval_expr(id1, env) do
	    :error ->
    	  :error
    	{:ok, str} ->
    	  vars = extract_vars(...)
    	  env = Env.remove(vars, ...)

    		case eval_match(..., ..., ...) do
        	:fail ->
          	:error
        	{:ok, env} ->
        	eval_seq(..., ...)
      		end
  		end
	end

	def extract_vars(patt) do
		extract_vars(patt, [])
	end

	def extract_vars({:cons, head, tail}, variables) do
		extract_vars(tail, extract_vars(head, variables))
	end

	def extract_vars({:atm, _}, variables) do
		variables
	end

	def extract_vars({:var, id}, variables)do
		[id|variables]
	end

	def extract_vars({:ignore, _}, variables) do
		variables
	end

		
end