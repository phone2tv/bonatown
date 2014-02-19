class PublicLiabilityItemsController < ApplicationController
  before_action :set_public_liability_item, only: [:show, :edit, :update, :destroy]

  # GET /public_liability_items
  # GET /public_liability_items.json
  def index
    @public_liability_items = PublicLiabilityItem.all
  end

  # GET /public_liability_items/1
  # GET /public_liability_items/1.json
  def show
  end

  # GET /public_liability_items/new
  def new
    insurance = Insurance.find params[:insurance_id]
    @public_liability_item = PublicLiabilityItem.new(insurance_id: params[:insurance_id])
    @public_liability_item.build_line_item(user_id: current_user.id, price: insurance.price)
    @public_liability_item.elevators.build
    @public_liability_item.build_insurance_business
  end

  # GET /public_liability_items/1/edit
  def edit
  end

  # POST /public_liability_items
  # POST /public_liability_items.json
  def create
    @public_liability_item = PublicLiabilityItem.new(public_liability_item_params)

    respond_to do |format|
      if @public_liability_item.save
        format.html { redirect_to @public_liability_item, notice: 'Public liability item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @public_liability_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @public_liability_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /public_liability_items/1
  # PATCH/PUT /public_liability_items/1.json
  def update
    respond_to do |format|
      if @public_liability_item.update_with_conflict_validation(public_liability_item_params)
        format.html { redirect_to @public_liability_item, notice: 'Public liability item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @public_liability_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /public_liability_items/1
  # DELETE /public_liability_items/1.json
  def destroy
    @public_liability_item.destroy
    respond_to do |format|
      format.html { redirect_to public_liability_items_url }
      format.json { head :no_content }
    end
  end

  # POST /accident_items/add_to_cart
  def add_to_cart
    @public_liability_item = PublicLiabilityItem.new(insurance_id: params[:insurance_id], business_type: 1)
    @public_liability_item.build_line_item(user_id: current_user.id)
    respond_to do |format|
      if @public_liability_item.save
        format.html { redirect_to :back, notice: 'PublicLiability insurance was added to cart.' }
        format.json { render action: 'show', status: :created, location: @public_liability_item }
      else
        format.html { redirect_to :back, alert: 'PublicLiability insurance was failed to add to cart.' }
        format.json { render json: @public_liability_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public_liability_item
      @public_liability_item = PublicLiabilityItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def public_liability_item_params
      params.require(:public_liability_item).permit(:insurance_id, :business_place, :business_type, :with_fire_control, :with_security_measure, :line_item_attributes => [:user_id, :price, :quantity, :name, :telephone, :code_number, :enterprise_name, :province, :city, :district, :location, :zipcode, :lock_version], :insurance_business_attributes => [:name, :telephone, :code_number, :enterprise_name, :province, :city, :district, :location, :zipcode], :elevators_attributes => [:id, :kind, :quantity, :year_of_manufacture, :using_years, :overhaul_interval, :_destroy])
    end
end
