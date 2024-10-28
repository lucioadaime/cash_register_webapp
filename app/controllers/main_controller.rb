class MainController < ApplicationController
  def menu
    @products = Product.preset_products

    if session[:cart]
      @cart = Cart.from_hash(session[:cart])
    else
      reset_cart
      @cart = Cart.new
      @cart.add_product("GR1", 1)  # Example items
      @cart.add_product("SR1", 1)
    end

    # Only store product codes and quantities in the session
    session[:cart] = @cart.to_hash

    # Render your views as usual
  end

private

  def set_cart
    session[:cart] ||= {}  # Initialize session[:cart] as an empty hash if it’s nil
    @cart = Cart.new(session[:cart])
  end

  def reset_cart
    session[:cart] = nil
    puts "CART CLEARED"
  end
end
