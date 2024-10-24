class MainController < ApplicationController
  before_action :set_cart

  def menu
    @products = Product.preset_products
  end
  private

  def set_cart
    # Initialize the cart from the session or create a new cart object
    @cart = session[:cart] ? Cart.new(session[:cart]) : Cart.new
  end
end
