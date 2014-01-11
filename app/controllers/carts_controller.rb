class CartsController < ApplicationController
  def show
    if current_user.has_role? :customer
      @line_items = current_user.line_items.where(order_id: nil)
      state = params[:state]
      @line_items = @line_items.where(aasm_state: state) if state.present?
      @line_items = @line_items.order(created_at: :desc)
    else
      redirect_to root_path, alert: "only customer can use shopping cart."
    end
  end

  def destroy
    current_user.line_items.where(order_id: nil).uncommitted.destroy_all
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
