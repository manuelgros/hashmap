# 1.) How to keep track of Keys to determine if collision or reassignment? => save key/value pair as Node
# 2.) Best way to grow bucket. If create new array how to copy exisiting elements over? 
require './lib/node'
require './lib/linked_list'

class HashMap

  attr_accessor :bucket, :capacity
  attr_reader :load_factor

  def initialize
    @capacity = 16
    @bucket = Array.new(capacity)
    @load_factor = 0.8
  end
  
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code%capacity
  end

  def bucket_near_capacity?
    capacity*load_factor < bucket.count { |element| !element.nil? }
  end

  def grow_bucket
    old_bucket = @bucket
    @capacity *= 2
    @bucket = Array.new(capacity)
    copy_old_bucket(old_bucket, bucket)
  end

  def copy_old_bucket(old_bucket, new_bucket)
    old_bucket.each do |element|
      unless element.nil?
        new_bucket[hash(element.head.key)] = element
      end
    end
  end
  
  def set(key, value)
    hashed_key = hash(key)
    return bucket[hashed_key] = LinkedList.new.append(key, value) if bucket[hashed_key].nil?

    if bucket[hashed_key].contains?(key)
      bucket[hashed_key].at(bucket[hashed_key].find(key)).value = value
    else
      bucket[hashed_key].append(key, value)
    end
    grow_bucket if bucket_near_capacity?
  end

  # hash(key) <= bucket.length necessary? The way my hash() works the resulting index can't exceed array length
  def get(key)
    if bucket[hash(key)] != nil && hash(key) <= bucket.length 
      bucket[hash(key)].at(bucket[hash(key)].find(key)).value
    else
      nil
    end
  end
end

new_map = HashMap.new
new_map.set('Aoo', 'Boo')
new_map.set('Coo', 'Doo')
new_map.set('Eoo', 'Foo')