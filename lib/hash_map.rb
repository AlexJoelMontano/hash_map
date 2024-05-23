class HashMap
  def initialize
    @size = 16
    @buckets = Array.new(@size)
  end

  def hash(key)
    hash_code = 0
    prime_number = 2029

    key.each_char { |char| hash_code = (hash_code * prime_number + char.ord) }

    hash_code
  end

  def set(key, value)
    index = hash(key) % @size
    @buckets[index] = value

    if length >= @size * 0.75
      resize = @size * 2
      new_buckets = Array.new(resize)

      @buckets.compact.each do |old_key, old_value|
        new_index = hash(old_key) % resize
        new_buckets[new_index] = old_value
      end

      @size = resize
      @buckets = new_buckets
    end
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
    count += 1 unless bucket.nil?
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

  def keys
    keys = []

    @buckets.each do |key, _|
      keys << key unless key.nil?
    end

    keys
  end
end

map = HashMap.new

num = 0
16.times do
  num += 1
  str = (0...6).map { ('a'..'z').to_a[rand(26)] }.join
  map.set(str,num)
  puts "#{str} : #{map.get(str)}"
end
