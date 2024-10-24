class Cart
  attr_reader :items

  def initialize(cart_data = {}, discount_manager = DiscountManager.new)
    @items = cart_data || {}
    @discount_manager = discount_manager
  end

  def add_product(product_code)
    product_code = product_code.to_s.upcase
    product = Product.find_by_code(product_code)

    raise ArgumentError, "Product not found" unless product

    if @items[product_code] # If product already in cart
      @items[product_code][:quantity] += 1
    else
      @items[product_code] = { product: product, quantity: 1 }
    end
  end

  def remove_product(product_code)
    product_code = product_code.to_s.upcase

    if @items[product_code]
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
end
