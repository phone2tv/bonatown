class OrdersController < ApplicationController
# before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_order, except: [:index, :new, :create]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    user_id = params[:user_id]
    @orders = @orders.where(user_id: user_id) if user_id.present?

    state = params[:state]
    @orders = @orders.where(aasm_state: state) if state.present?

    @orders = @orders.order(created_at: :desc)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    if params[:order] && params[:order][:line_items]
      @order = current_user.orders.build(order_params)
      # current_cart.line_items.quoted.each do |line_item|
      line_items = LineItem.where(id: params[:order][:line_items])

      line_items.quoted.each do |line_item|
        line_item.cart = nil
        @order.line_items << line_item
      end

      respond_to do |format|
        if @order.save
          format.html { redirect_to @order, notice: 'Order was successfully created.' }
          format.json { render action: 'show', status: :created, location: @order }
        else
          format.html { render action: 'new' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: 'At least select one item.' }
      end
    end

  # @order = current_user.orders.build(order_params)
  # current_cart.line_items.quoted.each do |line_item|
  #   line_item.cart = nil
  #   @order.line_items << line_item
  # end

  # respond_to do |format|
  #   if @order.save
  #     format.html { redirect_to @order, notice: 'Order was successfully created.' }
  #     format.json { render action: 'show', status: :created, location: @order }
  #   else
  #     format.html { render action: 'new' }
  #     format.json { render json: @order.errors, status: :unprocessable_entity }
  #   end
  # end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def pay
    @order.pay!
    @order.line_items.each do |line_item|
      line_item.pay!
      current_user.trace(line_item, 'pay')
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Order was successfully paid.' }
      format.json { head :no_content }
    end
  end

  def ship
    @order.ship!
    @order.line_items.each do |line_item|
      line_item.ship!
      current_user.trace(line_item, 'ship')
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Order was successfully shipped.' }
      format.json { head :no_content }
    end
  end

  # NOT cancel line_items (put them back into cart)
  def cancel
    @order.line_items.each do |line_item|
      line_item.order = nil
      line_item.cart = current_cart
      line_item.save
    end
    @order.destroy
    respond_to do |format|
      format.html { redirect_to cart_url, notice: 'Order was successfully cancelled.' }
      format.json { head :no_content }
    end
  end

# # cancel line_items too
# def cancel
#   @order.cancel!
#   @order.line_items.each do |line_item|
#     line_item.cancel!
#     current_user.trace(line_item, 'cancel')
#   end
#   respond_to do |format|
#     format.html { redirect_to :back, notice: 'Order was successfully cancelled.' }
#     format.json { head :no_content }
#   end
# end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:address)
    end
end
