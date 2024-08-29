require './lib/node'
require './lib/linked_list'

class HashMap

  attr_accessor :bucket, :capacity
  attr_reader :load_factor

  def initialize
    @capacity = 16
    @bucket = Array.new(capacity)
    @load_factor = 0.75
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
  
  # change so returns added Node?
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
    hashed_key = hash(key)
    if bucket[hashed_key] != nil && hashed_key <= bucket.length 
      bucket[hashed_key].at(bucket[hashed_key].find(key)).value
    else
      nil
    end
  end

  def has?(key)
    hashed_key = hash(key)
    return false if bucket[hashed_key].nil?

    bucket[hashed_key].contains?(key)
  end

  def remove(key)
    hashed_key = hash(key)
    return nil unless has?(key)

    if bucket[hashed_key].size == 1
      deleted_value = bucket[hashed_key].head.value
      bucket[hashed_key] = nil
      deleted_value
    else
      bucket[hashed_key].remove_at(bucket[hashed_key].find(key))
    end
  end

  def clear
    @bucket = Array.new(capacity)
  end

  def length
    count = 0
    bucket.each do |element|
      count += element.size unless element.nil?
    end
    count
  end

  def keys
    bucket.reduce([]) do |array, element|
      unless element.nil?
        element.each {|node| array << node.key}
      end
      array
    end
  end

  def values
    bucket.reduce([]) do |array, element|
      unless element.nil?
        element.each {|node| array << node.value}
      end
      array
    end
  end

  def entries
    bucket.reduce([]) do |array, element|
      unless element.nil?
        element.each {|node| array << [node.key, node.value]}
      end
      array
    end
  end
end