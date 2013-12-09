class LineItemsController < ApplicationController
  before_action :set_line_item, except: [:index, :new, :create]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
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
  # @insurance = Insurance.find(params[:insurance_id])
  # @line_item = LineItem.new(line_item_params)
    @line_item = @cart.line_items.build(line_item_params)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item, notice: 'LineItem was successfully created.' }
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
      format.html { redirect_to line_items_url }
      format.json { head :no_content }
    end
  end

  def commit
    @line_item.commit!
    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def cancel
    @line_item.cancel!
    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def verify
    @line_item.verify!
    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def quote
    @line_item.quote!
    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def reject
    @line_item.reject!
    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def pay
    @line_item.pay!
    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: 'LineItem was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def ship
    @line_item.ship!
    respond_to do |format|
      format.html { redirect_to cart_index_url, notice: 'LineItem was successfully updated.' }
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
      params.require(:line_item).permit(:insurance_id)
    end
end
