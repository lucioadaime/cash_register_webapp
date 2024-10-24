Rails.application.routes.draw do
  root 'main#menu'  # The main menu

  # Define routes for cart actions
  resource :cart, only: [ :show ] do
    post 'add_product', to: 'carts#add_product'  # POST for adding product to cart
    delete 'remove_product', to: 'carts#remove_product'  # DELETE for removing product
    post 'checkout', to: 'carts#checkout'  # POST for checkout
  end

  # Route for displaying the form to add a product (GET request)
  #  get 'cart/add_product', to: 'products#new', as: 'new_cart_product'
end
