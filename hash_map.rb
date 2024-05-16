class HashMap
  def initialize
    @size = 16
    @buckets = Array.new(@size)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (hash_code * prime_number + char.ord) }

    hash_code
  end

  def set(key, value)
    index = hash(key) % @size
    @buckets[index] = value
  end

  def get(key)
    index = hash(key) % @size
    return 'nil' if @buckets[index].nil?

    @buckets[index]
  end

  def has?(key)
    index = hash(key) % @size
    return false if @buckets[index].nil?

    true
  end

  def length
    count = 0

    @buckets.each do |bucket|
      if bucket.nil?
        count
      else
        count += 1
      end
    end
    count
  end

  def remove(key)
    index = hash(key) % @size
    @buckets[index] = nil
    return unless @buckets[index].nil?

    p nil
  end

  def values
    values = []

    @buckets.each do |bucket|
      values << bucket unless bucket.nil?
    end

    values
  end

  def indexes
    indexes = {}
    @buckets.each_with_index do |bucket,i|
      indexes[i] = bucket unless bucket.nil?
    end
    indexes
  end
end
