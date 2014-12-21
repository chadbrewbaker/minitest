


def mtest(a,b)
	if(a.inspect != b.inspect)
		puts "Error"
		puts a.inspect
		puts b.inspect
		puts "----"
	end
end

PRNG = Random.new()
#gen/choose 5 9
#gen_choose(5,9)

def gen_choose(low, high)
	return PRNG.rand(high - low +1)+(low)
end

#mtest(gen_choose(3,20), gen_choose)

puts gen_choose(3,7).inspect
puts gen_choose(3,7).inspect
puts gen_choose(3,7).inspect
puts gen_choose(3,7).inspect
puts gen_choose(3,7).inspect
puts gen_choose(3,7).inspect
puts gen_choose(3,7).inspect
puts gen_choose(3,7).inspect

def gen_one_of (gens)
	return gens[PRNG.rand(gens.length) -1]
end

puts (gen_one_of(["cat", 'd', [4,5], 9.0])).inspect
puts (gen_one_of(["cat", 'd', [4,5], 9.0])).inspect
puts (gen_one_of(["cat", 'd', [4,5], 9.0])).inspect
puts (gen_one_of(["cat", 'd', [4,5], 9.0])).inspect

def gen_sample( gen, max_len=20)
	ret =[]
	PRNG.rand(max_len).times do |i|
	 	ret.push(gen.call())
	end
	return ret
end
seven_eleven = ->() { ([7,11])[PRNG.rand(2) -1] }

puts (gen_sample (seven_eleven)).inspect
puts (gen_sample (seven_eleven)).inspect
puts (gen_sample (seven_eleven)).inspect
puts (gen_sample (seven_eleven)).inspect

