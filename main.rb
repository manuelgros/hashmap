# 1.) How to keep track of Keys to determine if collision or reassignment? => save key/value pair as Node
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
  
  def set(key, value)
    selected_bucket = bucket[hash(key)] 
      return selected_bucket = LinkedList.new.append(key, value) if selected_bucket.nil?

      if selected_bucket.contains?(key)
        selected_bucket.at(selected_bucket.find(key)).value = value
      else
        selected_bucket.append(key, value)
      end
  end
end

