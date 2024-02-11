class Node
  attr_reader :key
  attr_accessor :value, :next_node

  def initialize(key, value, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def append(key, value)
    return start_list(key, value) if empty_list?

    tail.next_node = Node.new(key, value)
  end

  def prepend(key, value)
    @head = Node.new(key, value, @head)
  end

  def size
    return 0 if empty_list?

    current = @head
    counter = 1

    until last_node?(current)
      counter += 1
      current = current.next_node
    end

    counter
  end

  def tail
    return nil if empty_list?

    node = @head

    node = node.next_node until last_node?(node)

    node
  end

  def contains?(key)
    return false if empty_list?

    current = @head

    until last_node?(current)
      return true if current.key == key
      current = current.next_node
    end

    false
  end

  def find(key)
    return nil if empty_list?

    current = @head

    loop do
      return current.value if current.key == key
      break if last_node?(current)
      current = current.next_node
    end

    nil
  end

  def empty_list?
    @head.nil?
  end

  private

  def start_list(key, value)
    @head = Node.new(key, value)
  end

  def last_node?(node)
    node.next_node.nil?
  end
end