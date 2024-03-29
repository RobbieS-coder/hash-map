require './lib/linked_list.rb'

class HashMap
  LOAD_FACTOR = 0.75

  def initialize
    @entry_count = 0
    @capacity = 16
    @buckets = Array.new(@capacity) { LinkedList.new }
  end

  def set(key, value)
    index = hash(key) % @capacity
    list = @buckets[index]
    entry = list.find(key)

    if entry
      entry.value = value
    elsif load_factor_exceeded?
     grow_capacity
     set(key, value)
    else
      list.append(key, value)
      @entry_count += 1
    end
  end

  def get(key)
    index = hash(key) % @capacity
    list = @buckets[index]

    list.find(key)
  end

  def has?(key)
    index = hash(key) % @capacity
    list = @buckets[index]

    return false if list.nil?

    list.contains?(key)
  end

  def remove(key)
    index = hash(key) % @capacity
    list = @buckets[index]

    if has?(key)
      list_index = list.find_index(key)
      deleted_value = list.remove_at(list_index)
      @entry_count -= 1
      return deleted_value
    end

    nil
  end

  def length
    @entry_count
  end

  def clear
    @entry_count = 0
    @capacity = 16
    @buckets = Array.new(@capacity) { LinkedList.new }
  end

  def keys
    keys = []

    entries.each { |entry| keys << entry[0] }

    keys
  end

  def values
    values = []

    entries.each { |entry| values << entry[1] }

    values
  end

  def entries
    arr = []

    @buckets.each do |list|
      next if list.empty_list?

      list.each { |node| arr << [node.key, node.value] }
    end

    arr
  end

  private

  def load_factor_exceeded?
    (@entry_count.to_f / @capacity) > LOAD_FACTOR
  end

  def grow_capacity
    @capacity *= 2
    current_entries = entries
    @buckets = Array.new(@capacity) { LinkedList.new }

    @entry_count = 0
    current_entries.each { |node| set(node[0], node[1]) }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end
end