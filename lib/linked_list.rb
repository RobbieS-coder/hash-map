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
    counter = 0

    while current
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

    while current
      return true if current.key == key
      current = current.next_node
    end

    false
  end

  def find(key)
    return nil if empty_list?

    current = @head

    while current
      return current.value if current.key == key
      current = current.next_node
    end

    nil
  end

  def find_index(key)
    current_index = 0
    current = @head

    while current
      return current_index if current.key == key
      current = current.next_node
      current_index += 1
    end

    nil
  end

  def remove_at(index)
    if index == 0
      value = @head.value
      @head = @head.next_node
      value
    else
      current_index = 0
      current = @head
      previous = nil

      until current_index == index
        previous = current
        current = current.next_node
        current_index += 1
      end

      previous.next_node = current.next_node

      current.value
    end
  end

  def empty_list?
    @head.nil?
  end

  def each
    current = @head

    while current
      yield(current)
      current = current.next_node
    end
  end

  private

  def start_list(key, value)
    @head = Node.new(key, value)
  end

  def last_node?(node)
    node.next_node.nil?
  end
end