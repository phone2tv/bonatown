class LineItemsController < ApplicationController
  before_action :set_line_item, except: [:index, :new, :create]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    state = params[:state]
    @line_items = @line_items.where(aasm_state: state) if state.present?

    user_id = params[:user_id]
    @line_items = @line_items.where(user_id: user_id) if user_id.present?

    order_id = params[:order_id]
    @line_items = @line_items.where(order_id: nil) if order_id.present?
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @cart = current_cart
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
  # @insurance = Insurance.find(params[:insurance_item_id])
    @line_item = @cart.add_insurance(line_item_params)
    @line_item.user = current_user

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to :back, notice: 'Insurance was successfully added to cart.' }
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'LineItem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_url }
      format.json { head :no_content }
    end
  end

  def commit
    @line_item.commit!
    current_user.track(@line_item, params[:action])
    respond_to do |format|
      format.html { redirect_to :back, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def cancel
    if @line_item.uncommitted?
      @line_item.destroy
    else
      @line_item.cart = nil
      @line_item.cancel!
      current_user.track(@line_item, params[:action])
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def verify
    @line_item.verify!
    current_user.track(@line_item, params[:action])
    respond_to do |format|
      format.html { redirect_to :back, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def quote
    @line_item.quote!
    current_user.track(@line_item, params[:action])
    respond_to do |format|
      format.html { redirect_to :back, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def reject
    @line_item.reject!
    current_user.track(@line_item, params[:action])
    respond_to do |format|
      format.html { redirect_to :back, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def pay
    order = current_user.orders.build
    order.line_items << @line_item
    order.order_number = order.make_order_number(current_user.id, @line_item.id)
    if order.save
      redirect_to order, notice: 'Order was successfully created.'
    else
      redirect_to :back, notice: 'Order was failed to create.'
    end

  # @line_item.pay!
  # current_user.track(@line_item, params[:action])
  # respond_to do |format|
  #   format.html { redirect_to :back, notice: 'LineItem was successfully updated.' }
  #   format.json { head :no_content }
  # end
  end

  def ship
    @line_item.ship!
    current_user.track(@line_item, params[:action])
    respond_to do |format|
      format.html { redirect_to :back, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:insurance_item_id, :insurance_item_type)
    end
end
