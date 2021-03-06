#Simple rose tree 

# (ns clojure.test.check.rose-tree
#   "A lazy tree data structure used for shrinking."
#   (:refer-clojure :exclude [filter remove seq])
#   (:require [clojure.core :as core]))

# (defn- exclude-nth
#   "Exclude the nth value in a collection."
#   [n coll]
#   (lazy-seq
#     (when-let [s (core/seq coll)]
#       (if (zero? n)
#         (rest coll)
#         (cons (first s)
#               (exclude-nth (dec n) (rest s)))))))

def mtest(a,b)
	if(a.inspect != b.inspect)
		puts "Error"
		puts a.inspect
		puts b.inspect
		puts "----"
	end
end
mtest("A", "A")
mtest(1, 1)
mtest([],[])

def rest( c )
	c.drop(1)
end

def exclude_nth_hash(n, collection)
	head = collection.first
	tail = rest(collection)
	if n.zero?
		return tail.to_h
	end
	return { (head[0]) => (head[1]) }.merge( exclude_nth_hash(n-1, tail) )
end

def exclude_nth_arraylike(n, collection)
	head = collection.first
	tail = rest(collection)
	if n.zero?
		return tail
	end
		return [head] + exclude_nth_arraylike(n-1, tail)
end

def exclude_nth(n,collection)
	if(collection.class.to_s == "Hash")
		exclude_nth_hash(n, collection)
	else
		exclude_nth_arraylike(n, collection)
	end
end

mtest(exclude_nth(0, [1,2,3]), [2,3])
mtest(exclude_nth(1, [1,2,3]), [1,3])
mtest(exclude_nth(2, [1,2,3]), [1,2])
h ={}
h['a'] =1
h[3] = 'b'
h[5] = "dog"
mtest(exclude_nth(0, h), {3=>"b", 5=>"dog"})
mtest(exclude_nth(1, h), {"a"=>1, 5=>"dog"})
mtest(exclude_nth(2, h), {"a"=>1, 3=>"b"})
require 'set'
s = Set.new [1,2,3]  
mtest(exclude_nth(0, s), [2, 3])
mtest(exclude_nth(1, s), [1,3])
mtest(exclude_nth(2, s), [1,2])






# (defn join
#   "Turn a tree of trees into a single tree. Does this by concatenating
#   children of the inner and outer trees."
#   {:no-doc true}
#   [[[inner-root inner-children] children]]
#   [inner-root (concat (map join children)
#                       inner-children)])

#join :: [inner_root inner_children] -> children -> ???
#join [ir ic] c = [ir (concat (map join c) ic)]		


def join(x)
	x
end


#(rose/join [])
#[nil ()]


#(rose/join [[] []])
#[nil ()]


# [1, [[2, [ [23, []] ], [3, []]    ]]

# (defn root
#   "Returns the root of a Rose tree."
#   {:no-doc true}
#   [[root _children]]
#   root)

def root(rtree)
	return rtree.first
end

# (defn children
#   "Returns the children of the root of the Rose tree."
#   {:no-doc true}
#   [[_root children]]
#   children)

def children(rtree)
	if rtree == []
		return []
	else
		rtree[1]
	end
end

#puts children( [0, []]     ).inspect
#puts children( [0, [ [1,[]]           ]]     ).inspect
#puts children( [0, [ [1,[]], [3,[]]  , [5,[]]          ]]     ).inspect

# (defn pure
#   "Puts a value `x` into a Rose tree, with no children."
#   {:no-doc true}
#   [x]
#   [x []])

def pure(x)
	return [x, []]
end
mtest(pure(5), [5,[]])
mtest(pure("Jaberwocky"), ["Jaberwocky",[]])

#(rose/pure "cat")
#["cat" []]


#(defn depth-one-children
#  [[root children]]
#  (into [] (map rose/root children)))

#(depth-one-children ["cat" [  [1] [2] [3] ]])
#[1 2 3]




# (defn fmap
#   "Applies functions `f` to all values in the tree."
#   {:no-doc true}
#   [f [root children]]
#   [(f root) (map (partial fmap f) children)])

def fmap(f, rtree)
	if rtree == []
		return []
	end
	if(rtree.length != 2)
		puts "ERROR"
		puts rtree.inspect
		puts "ERROR"
	end

	return [f.call(rtree.first)] + [rtree[1].inject([]) { |result, element| result + [fmap(f,element)] }]
end
double = ->(x) { x+x }
mtest(fmap(double, []), [])
mtest(fmap(double, [1, []] ), [2, []])
mtest(fmap(double, [1, [ [1,[]] ] ]), [2, [ [2, []] ]])
mtest(fmap(double, [1, [[2,[]], [3, []]]  ]), [2, [[4, []], [6, []]]])
mtest(fmap(double, [1, [[2,[]], [3, [ [4, []]  ]]]  ]), [2, [[4, []], [6, [ [8,[]]    ]]]])

#(rose/fmap inc (rose/pure 33))
#[34 ()]

#(rose/fmap inc [1, [ [1,[]] ] ])
#[2 ([2 ()])]


# (defn bind
#   "Takes a Rose tree (m) and a function (k) from
#   values to Rose tree and returns a new Rose tree.
#   This is the monadic bind (>>=) for Rose trees."
#   {:no-doc true}
#   [m k]
#   (join (fmap k m)))
def bind(k,m)
   join(fmap(k,m))
end

# (defn filter
#   "Returns a new Rose tree whose values pass `pred`. Values who
#   do not pass `pred` have their children cut out as well.
#   Takes a list of roses, not a rose"
#   {:no-doc true}
#   [pred [the-root children]]
#   [the-root (map (partial filter pred)
#                  (core/filter (comp pred root) children))])

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
#    (map (partial zip f)
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
#      (map (partial shrink f) (remove roses))]
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

#(rose/collapse (rose/pure "cat"))
#["cat" ()]

#(rose/collapse ["cat" [  [1] [2] [3] ]])
#["cat" ([1 ()] [2 ()] [3 ()])]



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

####TESTS####




#puts exclude_nth(0,h).inspect

