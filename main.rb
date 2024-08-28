# 1.) How to keep track of Keys to determine if collision or reassignment?
# 2.) Best way to grow bucket. If create new array how to copy exisiting elements over? 
require './lib/node'
require './lib/linked_list'

class HashMap

  attr_accessor :bucket, :capacity
  attr_reader :load_factor

  def initialize
    @bucket = Array.new(16)
    @capacity = 16
    @load_factor = 0.8
  end
  
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code%capacity
  end

  def grow_bucket
    if capacity*load_factor < bucket.count { |element| !element.nil? }
      @bucket = bucket + Array.new(capacity)
      @capacity *= 2
    end
  end

  # creating array with key and value is attempt to keep track of keys for probalem 1.)
  # def set(key, value)
  #   if bucket[hash(key)%capacity].nil? || bucket[hash(key)%capacity][0] == key
  #     bucket[hash(key)%capacity] = [key, value]
  #     grow_bucket
  #   end
  # end
  
  def set(key, value)
    # if bucket[hash(key)].nil? || bucket[hash(key)].key == key
      bucket[hash(key)] = LinkedList.new.append(key, value)
    # end
  end
end

# new_map = HashMap.new
# p new_map.bucket
# new_map.set("Carlos", "Martinez")
# p new_map.bucket
