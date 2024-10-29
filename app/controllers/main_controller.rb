class MainController < ApplicationController
  before_action :init_cart
  def menu
    @products = Product.preset_products

    if session[:cart]
      @cart = Cart.from_hash(session[:cart])
    else
      reset_cart
      @cart = Cart.new
      # @cart.add_product("GR1", 1)  # Example items
      # @cart.add_product("SR1", 1)
    end

    # Only store product codes and quantities in the session
    session[:cart] = @cart.to_hash

    # Render your views as usual
  end

private

def init_cart
  # Clear the cart only on the first load
  if session[:cart].nil?
    reset_cart
  end
end

  def reset_cart
    session[:cart] = nil
    puts "CART CLEARED"
  end
end
