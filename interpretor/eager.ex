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

	def eval_expr({:lambda, par, free, seq}, env) do
 		case Env.closure(free, env) do
  			:error ->
  				:error
   			closure ->
   				{:ok, {:closure, par, seq, closure}}
  		end
	end

	def eval_expr({:apply, expr, args}, env) do
		case eval_expr(expr, env) do
    		:error ->
      			:error
    		{:ok, {:closure, par, seq, closure}} ->
      			case eval_arguments(args, env) do
        			:error ->
          				:foo
        			strs ->
          				env = Env.args(par, strs, closure)
          				eval_seq(seq, env)
      end
  end
end

	def eval_expr({:case, expr, cls}, env) do
		case eval_expr(expr, env) do
			:error ->
				:error
			{:ok, str} ->
				eval_cls(cls, str, env)
		end
	end

	def eval_cls([], _, _) do
  		:error
	end

	def eval_cls([{:clause, ptr, seq} | cls], str, env) do
 		{_, clause_str} = eval_expr(ptr, env)
 		 match = eval_match({:atm, str}, clause_str, env)
 		case match do
    		:fail ->
    		  eval_cls(cls, str, env)

    		{:ok, env} ->
     			 eval_seq(seq, env)
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
	def eval_arguments([], env) do [] end
	def eval_arguments([h|t], env) do
		case eval_expr(h, env) do
			:error ->
				:error
			{:ok, str} ->
				case eval_arguments(t, env) do
					:error ->
						:error
					rest ->
						[str|rest]

				end
		end 
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

	def closure(keys, env) do
		List.foldr(keys, [], fn(key, acc) ->
			case acc do
				:error ->
					:error
				closure ->
					case Env.lookup(key, env) do
						{key, str} ->
							[{key, str}|closure]
						:nil ->
							:error
					end
				end
			end)
	end
	def args([], [], env) do env end
	def args([h|t], [str|rest], env) do
		args(t, rest, add(h, str, env))
	end
	def args([], _, env) do :error end
	def args(_, [], env) do :error end
end