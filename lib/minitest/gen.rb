



def mtest(a,b, line = "?")
	if(a.inspect != b.inspect)
		puts "Error line " + line.to_s
		puts a.inspect
		puts b.inspect
		puts "----"
	end
end

PRNG = Random.new()



# (ns cljs.test.check.rose-tree
#   "A lazy tree data structure used for shrinking."
#   (:refer-clojure :exclude [filter remove seq])
#   (:require [cljs.core :as core]))

#data RoseTree a = RoseTree a [ RoseTree a ]

#is_rose :: a -> Bool
is_rose = -> (r){ 	
					if r.length != 2
						#puts "len NEQ 2"
						return false
					end
					if 	r[1].length  ==  0
						#puts "second len == 0"
						return true
					end
					
					x = r[1].collect{ |c| 
						#puts ">>" + is_rose.call(c).inspect 
						is_rose.call(c) 
					}
					x.uniq!
					
					if (x == [true])
						return true
					else
						#puts "False with " + x.inspect
						return false
					end
					
					
				}

mtest( true , is_rose.call(['cat', [] ]) , __LINE__)

mtest( false , is_rose.call([ [] ]) , __LINE__)


#gen_rose_singleton :: a -> RoseTree a
gen_rose_singleton = ->(a){[a, [] ]  }

mtest( true , is_rose.call( gen_rose_singleton.call(1) ) , __LINE__)

#gen_rose_binary :: a -> a -> a -> RoseTree a
gen_rose_binary = ->(a,b,c){[a, [  [b, [] ] , [c, [] ]    ] ]  }

mtest( true , is_rose.call( gen_rose_binary.call(1,2,3) ) , __LINE__)



#root :: RoseTree a -> a
root = -> (r){ r[0] }
mtest( "cat" , root.call( gen_rose_singleton.call("cat") ))
mtest( gen_rose_singleton.call("cat")  ,  gen_rose_singleton.call(root.call( gen_rose_singleton.call("cat")  )))

# (defn- exclude-nth
#   "Exclude the nth value in a collection."
#   [n coll]
#   (lazy-seq
#     (when-let [s (core/seq coll)]
#       (if (zero? n)
#         (rest coll)
#         (cons (first s)
#               (exclude-nth (dec n) (rest s)))))))

exclude_nth = ->(n,coll){ coll.delete_at(n)   }

mtest ( [1,2,3] , aexclude_nth.call( 1 , [1,7,2,3] ))


# (defn join
#   "Turn a tree of trees into a single tree. Does this by concatenating
#   children of the inner and outer trees."
#   {:no-doc true}
#   [[[inner-root inner-children] children]]
#   [inner-root (concat (map join children)
#                       inner-children)])

# (defn root
#   "Returns the root of a Rose tree."
#   {:no-doc true}
#   [[root _children]]
#   root)

# (defn children
#   "Returns the children of the root of the Rose tree."
#   {:no-doc true}
#   [[_root children]]
#   children)

# (defn pure
#   "Puts a value `x` into a Rose tree, with no children."
#   {:no-doc true}
#   [x]
#   [x []])

# (defn fmap
#   "Applies functions `f` to all values in the tree."
#   {:no-doc true}
#   [f [root children]]
#   [(f root) (map #(fmap f %) children)])

# (defn bind
#   "Takes a Rose tree (m) and a function (k) from
#   values to Rose tree and returns a new Rose tree.
#   This is the monadic bind (>>=) for Rose trees."
#   {:no-doc true}
#   [m k]
#   (join (fmap k m)))

# (defn filter
#   "Returns a new Rose tree whose values pass `pred`. Values who
#   do not pass `pred` have their children cut out as well.
#   Takes a list of roses, not a rose"
#   {:no-doc true}
#   [pred [the-root children]]
#   [the-root (map #(filter pred %)
#               (core/filter #(pred (root %)) children))])

# (defn permutations
#   "Create a seq of vectors, where each rose in turn, has been replaced
#   by its children."
#   {:no-doc true}
#   [roses]
#   (apply concat
#          (for [[rose index]
#                (map vector roses (range))]
#            (for [child (children rose)] (assoc roses index child)))))

# (defn zip
#   "Apply `f` to the sequence of Rose trees `roses`."
#   {:no-doc true}
#   [f roses]
#   [(apply f (map root roses))
#    (map #(zip f %)
#         (permutations roses))])

# (defn remove
#   {:no-doc true}
#   [roses]
#   (concat
#     (map-indexed (fn [index _] (exclude-nth index roses)) roses)
#     (permutations (vec roses))))

# (defn shrink
#   {:no-doc true}
#   [f roses]
#   (if (core/seq roses)
#     [(apply f (map root roses))
#      (map #(shrink f %) (remove roses))]
#     [(f) []]))

# (defn collapse
#   "Return a new rose-tree whose depth-one children
#   are the children from depth one _and_ two of the input
#   tree."
#   {:no-doc true}
#   [[root the-children]]
#   [root (concat (map collapse the-children)
#                 (map collapse
#                      (mapcat children the-children)))])

# (defn- make-stack
#   [children stack]
#   (if-let [s (core/seq children)]
#     (cons children stack)
#     stack))

# (defn seq
#   "Create a lazy-seq of all of the (unique) nodes in a shrink-tree.
#   This assumes that two nodes with the same value have the same children.
#   While it's not common, it's possible to create trees that don't
#   fit that description. This function is significantly faster than
#   brute-force enumerating all of the nodes in a tree, as there will
#   be many duplicates."
#   [root]
#   (let [helper (fn helper [[node children] seen stack]
#                  (lazy-seq
#                    (if-not (seen node)
#                      (cons node
#                            (if (core/seq children)
#                              (helper (first children) (conj seen node) (make-stack (rest children) stack))
#                              (when-let [s (core/seq stack)]
#                                (let [f (ffirst s)
#                                      r (rest (first s))]
#                                  (helper f (conj seen node) (make-stack r (rest s)))))))
#                      (when-let [s (core/seq stack)]
#                        (let [f (ffirst s)
#                              r (rest (first s))]
#                          (helper f seen (make-stack r (rest s))))))))]
#     (helper root #{} '())))













# def foo()
# 	return 0
# end
# m = method(:foo)

# gen_isGenerator = -> (x){ x[0] == "Generator"  }

#gen_make_gen :: (a->b->c) -> gen
#gen_make_gen :: f -> gen f
#gen_make_gen = -> (generator_fn) {["Generator", generator_fn]}

#gen_call_gen = -> (gen, rand, size=100){gen.call(rand,size)}

#gen_gen_pure = -> (value){ make_gen.call( ->(rand,size){value}   )    }

#gen_fmap :: (a->b) -> f a -> f b
#gen_fmap = -> (k,h) { make_gen.call( ->(rand,size){ k.call( h.call(rand,size) )     }      )     }

#gen_return :: a -> Generators a 
#gen_make_gen

#gen_join :: Generators (Generators a) ->  Generators a

#gen_bind f xs = join (fmap f xs)
gen_bind = ->(f, xs){ gen_join.call( gen_fmap.call( f, xs)  )           }








#gen_bind = -> (h k) { make_gen.call( 
#		result = gen k 
#
 #    )      }

seven_eleven = ->() { ([7,11])[PRNG.rand(2) -1] }

#https://github.com/bbatsov/ruby-style-guide
# Use -> (x) {x} for single line lambdas
# use lambda (x) {x} for multi-line lambdas
#


#gen/choose 5 9
#gen_choose(5,9)

#def gen_choose(low, high)
#	return PRNG.rand(high - low +1)+(low)
#end

gen_choose = -> (low,high) { PRNG.rand(high - low +1)+(low) }


#mtest(gen_choose(3,20), gen_choose)

#10.times do
# puts gen_choose(3,7).inspect
#end


gen_elements = ->(list) { list[PRNG.rand(list.length) -1] }

gen_one_of = -> (gens) { (gens[PRNG.rand(gens.length) -1]).call()}


#10.times do
#	puts (gen_one_of.call(["cat", 'd', [4,5], 9.0])).inspect
#end

gen_such_that = -> (predicate, gen, max=100){
	ret = nil
	max.times do
		x = gen.call()
		if(predicate.call(x))
			ret = x
			break
		end
	end
	ret
}

not_seven = -> (x){x != 7}

10.times do 
	mtest( gen_such_that.call( not_seven, seven_eleven) , 11 )
end

#def gen_sample( gen, max_len=20)
#	ret =[]
#	PRNG.rand(max_len).times do |i|
#	 	ret.push(gen.call())
#	end
#	return ret
#end



gen_sample = -> (gen, max_len=20){
	ret =[]
	PRNG.rand(max_len).times do |i|
	 	ret.push(gen.call())
	end
	return ret
}



10.times do
	puts (gen_sample.call (seven_eleven)).inspect
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

#def gen_fmap( f, gen)
#	f.call(gen.call())
#end

#double = ->(x){x*2} 
#10.times do
#	puts gen_fmap(double, gen_pos_int)
#end


#10.times do
# 	puts gen_tuple(seven_eleven, gen_pos_int )
#end


#gen_bind = -> (gen, f ){ 
#	-> (gen){f.call(gen.call()) }
#}


gen_return = ->(x){x}


#pair-gen  = (gen_bind (gen_choose(1, 10)
#                        (fn [a]
#                          (gen/bind (gen/choose 1 a)
#                                    (fn [b]
#                                      (gen/return [a b]))))))


#10.times do
#	newgen = gen_bind.call( seven_eleven , ->(x){x*x}  )
#	puts (gen_sample.call (newgen)).inspect
#end





   


