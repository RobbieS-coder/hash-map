require './lib/linked_list.rb'

class HashMap
  def initialize
    @buckets = Array.new(16)
    @entry_count = 0
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
      @entry_count += 1
    end
  end

  def get(key)
    index = hash(key) % 16
    list = @buckets[index]

    list.find(key)
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end
end