require './lib/node'

# List class containing  the full list
class LinkedList

  # attr_accessor :name
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def prepend(key, value)
    node = Node.new(key, value)
    if @head.nil?
      @head = node
      @tail = node
    else
      node.next_node = @head
      @head = node
    end
  end

  def append(key, value)
    node = Node.new(key, value)
    if  @head.nil?
      @tail = node
      @head = node
    else
      @tail.next_node = node
      @tail = node
    end
    self
  end

  # def size
  #   count = 0
  #   active_node = @head
  #   until active_node == nil
  #     count += 1
  #     active_node = active_node.next_node
  #   end
  #   count
  # end

  def at(index)
    active_node = @head
    (index-1).times do 
      active_node = active_node.next_node
      
      return if active_node == nil
    end
    active_node
  end

  # def pop
  #   return nil if @tail.nil?

  #   active_node = @head
  #   until active_node.next_node == @tail
  #     active_node = active_node.next_node
  #   end
  #   @tail = active_node
  #   deleted_node = active_node.next_node
  #   active_node.next_node = nil
  #   deleted_node
  # end

  def contains?(key)
    active_node = @head
    until active_node == nil
      return true if active_node.key == key

      active_node = active_node.next_node
    end
    false
  end

  def find(key)
    active_node = @head
    index = 1
    until active_node == nil
      return index if active_node.key == key

      active_node = active_node.next_node
      index += 1
    end
    nil
  end

  def remove_at(index)
    return nil if @head == nil

    if index == 1
      deleted_node = @head
      @head = @head.next_node
      deleted_node
    else
      active_node = @head
      (index-2).times do
        active_node = active_node.next_node
        return self.pop if active_node == @tail

      end
      deleted_node = active_node.next_node
      active_node.next_node = active_node.next_node.next_node
      deleted_node
    end
  end
end