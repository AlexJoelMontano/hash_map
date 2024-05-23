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

Inventory = HashMap.new

#scenario of random amounts of crops
Crops = ["wheat", "corn", "canola", "sugarcane", "potatoes", "strawberries", "tomatoes", "lettuce"]

Crops.each do |crop|
  random = rand(1..500)
  Inventory.set(crop,random)
end

class Farm

  def initialize
    @crops = Crops
    @money = 100
  end

  def amount(crop)
    return Inventory.get(crop)
  end

  def sell(crop)
    puts "You currently have #{amount(crop)}"
    puts "How many #{crop} do you want to sell?"
    selling = gets.chomp.to_i

    price = rand(1..10)

    if selling > amount(crop)
      puts "You cannot sell more than you have enter a lower amount!"
    else
      inv = amount(crop)
      remain = inv - selling
      Inventory.set(crop, remain)

      puts "#{crop} is selling for #{price} per unit"
      profit = selling * price
      @money = @money + profit
      puts "You made #{profit} for selling #{selling} #{crop} you now have #{@money} in your wallet"
    end

    puts "You now have #{amount(crop)} remaining"
  end

  def view
    p crops
  end

  def money
    return @money
  end

  def buy(crop)
    puts "How many units do you want to buy?"
    buying = gets.chomp.to_i
    buying_price = rand(3..15)
    bought = buying * buying_price
    puts "#{crop} cost #{buying_price} per unit for a total of #{bought}, do you want to buy? (yes/no)"
    buy_choice = gets.chomp


    if buy_choice == 'yes'
      @money = @money - bought

      current = Inventory.get(crop)
      new_amount = current + buying
      Inventory.set(crop,new_amount)

      puts "You now have #{amount(crop)} in your inventory and #{@money} in your wallet"
    else
      puts "Nothing was bought you still have #{amount(crop)} in your inventory"
    end
  end
end

farm = Farm.new

puts "--------------------------------------"
puts "Farming Manager Simulator CLI edition"
puts "------------------------------------------------------------------------------------"
puts "Manage your farm by Buying, Selling, or Viewing your inventory of crops."
puts "------------------------------------------------------------------------------------"
puts "Crops:"
p Crops

game_choice = " "

until game_choice == 'exit'
  puts ' '
  puts "Menu: |view|  |sell|  |buy|  |wallet|  |exit|"
  game_choice = gets.chomp

  if game_choice == 'view'
    puts " "
    puts "Which crop do you want to view?"

    crop = gets.chomp
    puts "You have #{farm.amount(crop)} #{crop}"
    game_choice = crop
  elsif game_choice == 'sell'
    puts "Which crop do you want to sell?"

    crop = gets.chomp

    farm.sell(crop)
    game_choice = crop

  elsif game_choice == 'buy'
    puts "Which crop do you want to buy?"

    crop = gets.chomp

    farm.buy(crop)
    game_choice = crop
  else
    puts "You have $#{farm.money} in your wallet"

  end
end
