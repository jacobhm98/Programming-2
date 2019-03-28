defmodule Huffman do

 	def sample do
		'the quick brown fox jumps over the lazy dog
		this is a sample text that we will use when we build
		up a table we will only handle lower case letters and
		no punctuation symbols the frequency will of course not
		represent english but it is probably not that far off'
	end

	def text()  do
		'this is something that we should encode'
	end

	def test do
    	sample = sample()
    	tree = tree(sample)
    	encode = encode_table(tree)
    	decode = decode_table(tree)
    	text = text()
    	seq = encode(text, encode)
    	decode(seq, decode)
 	end

	def tree(sample) do
    	freq = freq(sample)
    	huffman(freq)
	end

	def huffman(freq) do
  		sort(freq, [])
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

	  	def sortf(({_, freq} = element), [({_, compFreq}) = head | rest]) when freq > compFreq do
	    	[head | sortf(element, rest)]
	  	end

	  	def sortf(element, sortedList) do
	    	[element|sortedList]
	  	end

  	def encode_table(tree) do
    	# To implement...
  	end

	def decode_table(tree) do
    	# To implement...
  	end

  	def encode(text, table) do
    	# To implement...
  	end

  	def decode(seq, tree) do
    	# To implement...
  	end

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
    	{element, 1}
  	end

  	def incrementFreq(element, [{element, count}|tail]) do
    	[{element, count + 1}|tail]
  	end

  	def incrementFreq(element, [noMatch | tail]) do
    	[noMatch|incrementFreq(element, tail)]
  	end

end