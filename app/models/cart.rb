class Cart
  attr_accessor :items, :discount_manager

  def initialize(cart_data = {}, discount_manager = DiscountManager.new)
    @items = cart_data || {}
    @discount_manager = discount_manager
  end

  def add_product(product_code, quantity = 1)
    product_code = product_code.to_s.upcase
    product = Product.find_by_code(product_code)

    if @items[product_code]
      puts "BEFORE Item #{product_code} with quantity #{@items[product_code][:quantity].to_i}"
      new_quantity = @items[product_code][:quantity].to_i + 1
      @items[product_code] = { product: product, quantity: new_quantity }
      puts "AFTER Item #{product_code} with quantity #{@items[product_code][:quantity].to_i}"
    else
      # Add product to cart if not already present
      raise ArgumentError, "Product not found" unless product
      @items[product_code] = { product: product, quantity: quantity }
    end
  end

  def remove_product(product_code)
    product_code = product_code.to_s.upcase
    if @items[product_code]
      # Decrease quantity if more than 1, otherwise remove from cart
      if @items[product_code][:quantity] > 1
        @items[product_code][:quantity] -= 1
      else
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
