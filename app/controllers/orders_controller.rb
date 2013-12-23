class OrdersController < ApplicationController
# before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_order, except: [:index, :new, :create]

  # GET /orders
  # GET /orders.json
  def index
  # @orders = Order.all
    @orders = current_user.orders

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
    line_items = current_cart.line_items.where(aasm_state: 'quoted')
    if line_items.empty?
      redirect_to cart_url, alert: "Order can't be empty."
      return
    end

    @order = current_user.orders.build(order_params)
    line_items.each do |line_item|
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
    @order.line_items.each { |line_item| line_item.pay! }
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Order was successfully paid.' }
      format.json { head :no_content }
    end
  end

  def ship
    @order.ship!
    @order.line_items.each { |line_item| line_item.ship! }
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Order was successfully shipped.' }
      format.json { head :no_content }
    end
  end

  def cancel
    @order.cancel!
    @order.line_items.each { |line_item| line_item.cancel! }
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Order was successfully cancelled.' }
      format.json { head :no_content }
    end
  end

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