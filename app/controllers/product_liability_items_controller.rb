class ProductLiabilityItemsController < ApplicationController
  before_action :set_product_liability_item, only: [:show, :edit, :update, :destroy]

  # GET /product_liability_items
  # GET /product_liability_items.json
  def index
    @product_liability_items = ProductLiabilityItem.all
  end

  # GET /product_liability_items/1
  # GET /product_liability_items/1.json
  def show
  end

  # GET /product_liability_items/new
  def new
    insurance = Insurance.find params[:insurance_id]
    @product_liability_item = ProductLiabilityItem.new(insurance_id: params[:insurance_id])
    @product_liability_item.build_line_item(user_id: current_user.id, price: insurance.price)
    @product_liability_item.build_insurance_business
  end

  # GET /product_liability_items/1/edit
  def edit
  end

  # POST /product_liability_items
  # POST /product_liability_items.json
  def create
    @product_liability_item = ProductLiabilityItem.new(product_liability_item_params)

    respond_to do |format|
      if @product_liability_item.save
        format.html { redirect_to @product_liability_item, notice: 'Product liability item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product_liability_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_liability_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_liability_items/1
  # PATCH/PUT /product_liability_items/1.json
  def update
    respond_to do |format|
      if @product_liability_item.update(product_liability_item_params)
        format.html { redirect_to @product_liability_item, notice: 'Product liability item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product_liability_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_liability_items/1
  # DELETE /product_liability_items/1.json
  def destroy
    @product_liability_item.destroy
    respond_to do |format|
      format.html { redirect_to product_liability_items_url }
      format.json { head :no_content }
    end
  end

  # POST /accident_items/add_to_cart
  def add_to_cart
    @product_liability_item = ProductLiabilityItem.new(insurance_id: params[:insurance_id], business_nature: 1)
    @product_liability_item.build_line_item(user_id: current_user.id)
    respond_to do |format|
      if @product_liability_item.save
        format.html { redirect_to :back, notice: 'ProductLiability insurance was added to cart.' }
        format.json { render action: 'show', status: :created, location: @product_liability_item }
      else
        format.html { redirect_to :back, alert: 'ProductLiability insurance was failed to add to cart.' }
        format.json { render json: @product_liability_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_liability_item
      @product_liability_item = ProductLiabilityItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_liability_item_params
      params.require(:product_liability_item).permit(:insurance_id, :business_nature, :each_accident_limit, :bodily_injury_limit, :property_damage_limit, :aggregate_limit, :started_at, :stopped_at, :line_item_attributes => [:user_id, :price, :quantity, :name, :telephone, :code_number, :enterprise_name, :province, :city, :district, :location, :zipcode, :lock_version], :insurance_business_attributes => [:name, :telephone, :code_number, :enterprise_name, :province, :city, :district, :location, :zipcode], :insured_products_attributes => [:id, :name, :kind, :nature, :use, :sales_area, :sales_volumn, :_destroy])
    end
end
