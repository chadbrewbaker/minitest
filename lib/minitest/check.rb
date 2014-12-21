

def quickcheck (num_tests, property, seed,max_size=100)
	0.upto(num_tests) |i|
		#if !property.evaluate(seed,max_size)
		#	puts property.print(seed,max_size)
		#end 
	end
end