class CartsController < ApplicationController
  def show
    if current_user.has_role? :customer
      @cart = current_cart
      @line_items = @cart.line_items
      state = params[:state]
      @line_items = @line_items.where(aasm_state: state) if state.present?
      @line_items = @line_items.order(updated_at: :desc)
    else
      redirect_to root_path, alert: "only customer can use shopping cart."
    end
  end

  def destroy
    @cart = current_cart
    @cart.line_items.destroy_all
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to cart_url, notice: 'Your cart is currently empty' }
      format.json { head :ok }
    end
  end

  private

    def current_resource
      current_cart
    end
end
