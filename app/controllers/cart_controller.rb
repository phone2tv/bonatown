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

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: 'Your cart is currently empty' }
      format.json { head :ok }
    end
  end
end
