class DiscountManager
  def initialize
    @discounts = load_discounts
  end

  def load_discounts
    file_path = File.expand_path("../../data/discounts.json", __dir__)
    JSON.parse(File.read(file_path))
  end

  def calculate_discounted_price(product, quantity)
    return 0 if product.nil? # Early return if product is nil

    discount = @discounts[product.code]
    if discount
      apply_discount(product, quantity, discount)
    else
      product.price * quantity # Return the regular price if no discount
    end
  end

  def apply_discount(product, quantity, discount)
    # Ensure quantity is a valid number
    quantity = quantity.to_i

    case discount["type"]
    when "BOGO"
      items_bogo = quantity / 2
      (quantity - items_bogo) * product.price

    when "bulk price drop"
      if quantity >= discount["min_quantity"]
        quantity * discount["new_price"]
      else
        quantity * product.price
      end

    when "bulk drop by percentage"
      if quantity >= discount["min_quantity"]
        (quantity * product.price * (1 - discount["%_price"])).round(2)
      else
        quantity * product.price
      end

    else
      quantity * product.price
    end
  end
end
