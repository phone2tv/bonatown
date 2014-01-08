class AccidentItemsController < ApplicationController
  before_action :set_accident_item, only: [:show, :edit, :update, :destroy]

  # GET /accident_items
  # GET /accident_items.json
  def index
    @accident_items = AccidentItem.all
  end

  # GET /accident_items/1
  # GET /accident_items/1.json
  def show
  end

  # GET /accident_items/new
  def new
    @accident_insurance = AccidentInsurance.find_by(id: params[:accident_insurance_id])
    @accident_item = AccidentItem.new(accident_insurance_id: @accident_insurance.id)
    @accident_item.build_line_item(user_id: current_user.id, cart_id: current_cart.id)
  end

  # GET /accident_items/1/edit
  def edit
  end

  # POST /accident_items
  # POST /accident_items.json
  def create
  # @accident_item = AccidentItem.new(accident_item_params)
  # if @accident_item.save
  #   line_item = current_cart.line_items.build(insurance_item: @accident_item)
  #   line_item.user = current_user
  #   line_item.save
  #   redirect_to @accident_item.specific_insurance, notice: 'Insurance was successfully added to cart.'
  # end

    @accident_item = AccidentItem.new(accident_item_params)
    respond_to do |format|
      if @accident_item.save
        format.html { redirect_to @accident_item, notice: 'Accident item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @accident_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @accident_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accident_items/1
  # PATCH/PUT /accident_items/1.json
  def update
    respond_to do |format|
      if @accident_item.update(accident_item_params)
        format.html { redirect_to @accident_item, notice: 'Accident item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @accident_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accident_items/1
  # DELETE /accident_items/1.json
  def destroy
    @accident_item.destroy
    respond_to do |format|
      format.html { redirect_to accident_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accident_item
      @accident_item = AccidentItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accident_item_params
      params.require(:accident_item).permit(:accident_insurance_id, :industry_id, :employee_number, :quota, :started_at, :stopped_at, :line_item_attributes => [:user_id, :cart_id, :price])
    end
end
