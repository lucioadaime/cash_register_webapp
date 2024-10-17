# app/controllers/carts_controller.rb
class CartsController < ApplicationController
    before_action :initialize_cart

    def show
      @cart_items = @cart.items
      @total_price = @cart.total_price
    end

    def add_product
      product = Product.find(params[:product_id])
      @cart.add_product(product.code)
      session[:cart] = @cart  # Save cart state to session
      redirect_to cart_path, notice: "#{product.name} added to cart"
    end

    def remove_product
      product = Product.find(params[:product_id])
      @cart.remove_product(product.code)
      session[:cart] = @cart  # Update session
      redirect_to cart_path, notice: "#{product.name} removed from cart"
    end

    def checkout
      @total_price = @cart.total_price
      @cart.empty_cart
      session[:cart] = @cart
      redirect_to cart_path, notice: "Checkout complete. Total: $#{@total_price}"
    end

    private

    def initialize_cart
      @cart = session[:cart] ||= Cart.new
    end
end
