class CartController < ApplicationController
  # GET /carts
  # GET /carts.json
  def index
    @cart = current_cart
    @line_items = @cart.line_items
  end
end
