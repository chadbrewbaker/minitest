


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

#10.times do
# puts gen_choose(3,7).inspect
#end

def gen_one_of (gens)
	return gens[PRNG.rand(gens.length) -1]
end

#10.times do
#	puts (gen_one_of(["cat", 'd', [4,5], 9.0])).inspect
#end

def gen_sample( gen, max_len=20)
	ret =[]
	PRNG.rand(max_len).times do |i|
	 	ret.push(gen.call())
	end
	return ret
end
seven_eleven = ->() { ([7,11])[PRNG.rand(2) -1] }

10.times do
 	puts (gen_sample (seven_eleven)).inspect
 end


def gen_tuple(g1, g2)
	return [g1.call(), g2.call()]
end




# (defn frequency
#   "Create a generator that chooses a generator from `pairs` based on the
#   provided likelihoods. The likelihood of a given generator being chosen is
#   its likelihood divided by the sum of all likelihoods
#   Examples:
#       (gen/frequency [[5 gen/int] [3 (gen/vector gen/int)] [2 gen/boolean]])
#   "
#   [pairs]
#   (assert (every? (fn [[x g]] (and (number? x) (generator? g)))
#                   pairs)
#           "Arg to frequency must be a list of [num generator] pairs")
#   (let [total (apply + (core/map first pairs))]
#     (gen-bind (choose 1 total)
#               #(pick pairs (rose/root %)))))

def gen_frequency(pairs)
	prefix_sum =[]
	gens = []
	accum = 0
	pairs.each{|p| 
		accum += p[0]
		prefix_sum.push(accum)
		gens.push(p[1])
	}
	# [[4, gen1], [5, gen2]]
	x = PRNG.rand(accum)+1
	return gens[prefix_sum.index{ |v| v >= x}]
end
#20.times do
#	puts gen_frequency( [[1,"cat"], [2,"dog"], [3, "wolf"]]).inspect
#end

gen_pos_int = -> () {PRNG.rand(100)}
	

#10.times do
#	puts gen_pos_int
#end

def gen_fmap( f, gen)
	f.call(gen.call())
end

#double = ->(x){x*2} 
#10.times do
#	puts gen_fmap(double, gen_pos_int)
#end


10.times do
 	puts gen_tuple(seven_eleven, gen_pos_int )
end




