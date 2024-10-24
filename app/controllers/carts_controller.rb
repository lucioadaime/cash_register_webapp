class CartsController < ApplicationController
    before_action :set_cart

    def show
      @cart_items = @cart.items
      @total_price = @cart.total_price
    end

    def add_product
        product_code = params[:product_code].to_s.upcase
        puts "Searching for product with code: #{product_code}"

        begin
          product = Product.find_by_code(product_code)
          @cart.add_product(product_code)  # Assuming add_product works with the product_code
          session[:cart] = @cart.items    # Update the session with the latest cart data
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
        @cart = session[:cart] ? Cart.new(session[:cart]) : Cart.new
      end

    # Save the cart to the session (only save the items, not the whole cart object)
    def save_cart
      session[:cart] = @cart.items
    end
end
