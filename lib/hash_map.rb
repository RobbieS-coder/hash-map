require './lib/linked_list.rb'

class HashMap
  def initialize
    @buckets = Array.new(16)
    @length = 0
  end

  def set(key, value)
    index = hash(key) % 16
    @buckets[index] ||= LinkedList.new
    list = @buckets[index]
    entry = list.find(key)

    if entry
      entry.value = value
    else
      list.append(key, value)
    end
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end
end