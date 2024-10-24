class CartsController < ApplicationController
    before_action :set_cart

    def show
      @cart_items = @cart.items
      puts "Cart items: #{@cart_items.inspect}" # Debugging line
      @total_price = @cart.total_price
    end

    def add_product
      product_code = params[:product_code].to_s.upcase
      @cart.add_product(product_code)

      # Save the updated cart to session
      save_cart

      respond_to do |format|
        format.html { redirect_to menu_path, notice: 'Product added!' }
        format.js   # For AJAX requests if applicable
      end
    rescue ArgumentError => e
      respond_to do |format|
        format.html { redirect_to menu_path, alert: e.message }
        format.js { render js: "alert('#{e.message}');" }  # Handle the error in JS
      end
    end

    def remove_product
      product_code = params[:product_code].to_s.upcase
      if @cart.remove_product(product_code)
        flash[:notice] = "Product removed from cart."
      else
        flash[:alert] = "Product not found in cart."
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
      # Initialize the cart using the session data or start with an empty cart
      @cart = Cart.new(session[:cart] || {})
    end

    # Save the cart to the session (only save the items, not the whole cart object)
    def save_cart
      session[:cart] = @cart.items
    end
end
