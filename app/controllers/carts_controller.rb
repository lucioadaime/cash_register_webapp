class CartsController < ApplicationController
    before_action :set_cart

    def show
      @cart_items = @cart.items
      @total_price = @cart.total_price
    end

    def add_product
        product_code = params[:product_code].to_s.upcase
        begin
        @cart = Cart.from_hash(session[:cart])  # Load cart from session hash
        @cart.add_product(product_code, params[:quantity].to_i)
        session[:cart] = @cart.to_hash  # Save updated cart back to session

        flash[:notice] = "Product added successfully!"
        rescue ArgumentError => e
          flash[:alert] = e.message
        end

        respond_to do |format|
          format.html { redirect_to menu_path }
          format.js   # For AJAX requests if applicable
        end
    end


    def remove_product
      product_code = params[:product_code].to_s.upcase
      @cart = Cart.from_hash(session[:cart])  # Load cart from session hash

      if @cart.remove_product(product_code)
        flash[:notice] = "Item removed from cart."
      else
        flash[:alert] = "Item not found in cart."
      end

      # Save the updated cart to session
      save_cart

      redirect_to menu_path
    end

    def checkout
      @total_price = @cart.total_price
      @cart.empty_cart

      # Save the empty cart back to session
      save_cart

      redirect_to menu_path, notice: "Checkout complete. Total: $#{@total_price}"
    end

    private

    def set_cart
        session[:cart] ||= {}  # Initialize session[:cart] as an empty hash if it’s nil
        @cart = Cart.new(session[:cart])
        puts "Cart in set_cart: #{@cart.items.inspect}"
    end


    # Save the cart to the session (only save the items, not the whole cart object)
    def save_cart
        session[:cart] = @cart
        puts "Cart in save_cart: #{@cart.items.inspect}"
    end
end
