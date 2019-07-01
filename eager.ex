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
	      case eval_expr(tail, env) do
	        :error ->
	          :error
	        {:ok, ts} ->
	          {:ok, [hs|ts]}
	      end
	  end
	end

	def eval_expr({:case, expr, cls}, env) do
		case eval_expr(expr, env) do
			:error ->
				:error
			{:ok, _} ->
				eval_cls()
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
				env = Env.add(hp, hs, env)
				eval_match(tp, ts, env)
		end
	end

	def eval_match(_, _, _) do
		:fail
	end

	def eval_cls()

	def eval_seq([{:match, id, str} = pattern | rest], env) do
		case eval_expr(str, env) do
	    :error ->
    	  :error
    	{:ok, str} ->
    	  vars = extract_vars(id)
    	  env = Env.remove(vars, env)

    		case eval_match(id, str, env) do
        	:fail ->
          	:error
        	{:ok, env} ->
        	eval_seq(rest, env)
      		end
  		end
	end

	def eval_seq([exp], env) do
  		eval_expr(exp, env)
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

	def extract_vars(:ignore, variables) do
		variables
	end

	def eval(seq) do
		eval_seq(seq, [])
	end

		
end

defmodule Env do
	def new() do
		[]
	end

	def add(id, str, env) do
		env ++ [{id, str}]
	end

	def lookup(id, [{id, str}|rest]) do
		{id, str}
	end

	def lookup(id, [_|t]) do
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