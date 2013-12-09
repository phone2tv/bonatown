class CartController < ApplicationController
  # GET /carts
  # GET /carts.json
  def index
    if current_user.has_role? :customer
      @cart = current_cart
      @line_items = @cart.line_items
    else
      redirect_to root_path, alert: "admin user can't use shopping cart."
    end
  end
end
