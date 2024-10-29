Rails.application.routes.draw do
  root 'main#menu'  # The main menu
  get 'menu', to: 'main#menu', as: 'menu'
  get 'menu', to: 'main#menu', as: 'main_menu'

  post 'checkout', to: 'main#checkout', as: 'checkout_cart'
  # Define routes for cart actions
  resource :cart, only: [ :show ] do
    post 'add_product', to: 'carts#add_product'  # POST for adding product to cart
    delete 'remove_product', to: 'carts#remove_product'  # DELETE for removing product
    post 'checkout', to: 'main#checkout', as: 'checkout_cart'
  end
end
