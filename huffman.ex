defmodule Huffman do

 	def sample do
		'the quick brown fox jumps over the lazy dog
		this is a sample text that we will use when we build
		up a table we will only handle lower case letters and
		no punctuation symbols the frequency will of course not
		represent english but it is probably not that far off'
	end

	def text  do
		'this is something that we should encode'
	end

	def test do
    	sample = text()
    	tree = tree(sample)
    	#encode = encode_table(tree)
    	#decode = decode_table(tree)
    	#text = text()
    	#seq = encode(text, encode)
    	#decode(seq, decode)
 	end

	def tree(sample) do
    	freq = freq(sample)
    	sorted = sort(freq)
    	huffman(sorted)
	end


	def huffman([tree | []]) do tree end

	def huffman([{_, _, freq1} = h1, {_, _, freq2} = h2 | rest]) do
		huffman(sortf({h1, h2, freq1 + freq2}, rest))
	end


	
	def sort(list) do sort(list, []) end

	#base case, if we have an empty list of unsorted elements, return sorted elements
		def sort([], sortedList) do
			sortedList
		end

		def sort([head | tail], sortedList) do
	  		sort(tail, sortf(head, sortedList))
	  	end

	#helper function that inserts the element in question in the right place of the sorted list
		def sortf(x, []) do
	  		[x]
	  	end

	  	def sortf((element = {_, _, freq}), [(head = {_, _, compFreq}) | rest]) when freq > compFreq do
	    	[head | sortf(element, rest)]
	  	end

	  	def sortf(element, sortedList) do
	    	[element|sortedList]
	  	end


	#given a tree encode_table will create an encoding table. Will contain the characters in the text along with a translation into bits.
  	def encode_table(tree) do
    	encode_table(tree, [])
  	end

  	def encode_table({:leaf, char, freq}, table, path) do
  		table ++ [{char, path}]	
  		
  	end

  	def encode_table({{left, right}, weight}, table) do
  		cond do
  			{:leaf, char, _freq} = left ->
  				encode_table(right, [{char, 0}], [1])

  			{:leaf, char, _freq} = right ->
  				encode_table(left, [{char, 1}], [0])
  		end
  	end

  	def encode_table({{left, right}, weight}, table, path) do
  		cond do
  			{:leaf, char, _freq} = left ->
  				encode_table(right, table ++ [{char, path ++ [0]}], path ++ [1])

  			{:leaf, char, _freq} = right ->
  				encode_table(left, table ++ [{char, path ++ [1]}], path ++ [0])
  			end
  	end
  	

	def decode_table(tree) do
    	# To implement...
  	end

  	def encode([], _) do
  		[]
  	end

  	def encode([h | t], table) do
  		[findMapping(h, table) | encode(t, table)]
  	end

  	def findMapping(element, [{element, [mapping]} | rest]) do
		[mapping] 		
  	end

  	def findMapping(element, [noMatch | rest]) do
  		findMapping(element, rest)
  	end

  	def decode(seq, tree) do
    	# To implement...
  	end


  	
  	#Create a frequency list given a sample text of the form {char, frequency}
  	
  	def freq(sample) do
    	freq(sample, [])
  	end

  	def freq([], freq) do
    	freq
  	end

  	def freq([head|tail], freq) do
    	freq(tail, incrementFreq(head, freq))
  	end

  	def incrementFreq(element, [])do
    	[{:leaf, element, 1}]
  	end

  	def incrementFreq(element, [{:leaf, element, count}|tail]) do
    	[{:leaf, element, count + 1}|tail]
  	end

  	def incrementFreq(element, [noMatch | tail]) do
    	[noMatch|incrementFreq(element, tail)]
  	end

end