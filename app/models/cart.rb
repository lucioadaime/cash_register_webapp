class Cart
  attr_accessor :items, :discount_manager

  def initialize(cart_data = {}, discount_manager = DiscountManager.new)
    @items = cart_data || {}
    @discount_manager = discount_manager
  end

  def add_product(product_code, quantity = 1)
    product_code = product_code.to_s.strip.upcase  # Normalize product_code
    product = Product.find_by_code(product_code)
    raise ArgumentError, "Product not found" unless product

    quantity = quantity.to_i
    quantity = 1 if quantity <= 0
    if @items.key?(product_code) # if already in cart
      current_quantity = @items[product_code][:quantity].to_i
      new_quantity = current_quantity + quantity
      @items[product_code][:quantity] = new_quantity
    else
      # Add new product with  quantity 1
      @items[product_code] = { product: product, quantity: quantity }
    end
  end



  def remove_product(product_code)
    product_code = product_code.to_s.upcase

    if @items.key?(product_code)
      current_quantity = @items[product_code][:quantity].to_i
      # Decrease quantity if more than 1, otherwise remove from cart
      if current_quantity > 1
        puts 'current_quantity > 1'
        new_quantity = current_quantity - 1
        @items[product_code][:quantity] = new_quantity
      else
        puts 'current_quantity = 1'
        @items.delete(product_code)
      end
      true
    else
      false
    end
  end

  def total_price
    @items.sum do |product_code, item|
      product = Product.find_by_code(product_code) # Retrieve the product from DB
      @discount_manager.calculate_discounted_price(product, item[:quantity])
    end
  end

  def empty?
    @items.empty?
  end

  def empty_cart
    @items.clear
  end

  def to_hash
    @items.transform_values { |item| { quantity: item[:quantity] } }
  end

  # Restore Cart from a simple hash
  def self.from_hash(hash)
    cart = new
    hash.each do |code, data|
      cart.add_product(code, data['quantity'])
    end
    cart
  end
end
