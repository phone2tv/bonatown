class EmployerLiabilityItemsController < ApplicationController
  before_action :set_employer_liability_item, only: [:show, :edit, :update, :destroy]

  # GET /employer_liability_items
  # GET /employer_liability_items.json
  def index
    @employer_liability_items = EmployerLiabilityItem.all
  end

  # GET /employer_liability_items/1
  # GET /employer_liability_items/1.json
  def show
  end

  # GET /employer_liability_items/new
  def new
    insurance = Insurance.find params[:insurance_id]
    @employer_liability_item = EmployerLiabilityItem.new(insurance_id: params[:insurance_id])
    @employer_liability_item.build_line_item(user_id: current_user.id, price: insurance.price)
    @employer_liability_item.build_insurance_business
  end

  # GET /employer_liability_items/1/edit
  def edit
  end

  # POST /employer_liability_items
  # POST /employer_liability_items.json
  def create
    @employer_liability_item = EmployerLiabilityItem.new(employer_liability_item_params)

    respond_to do |format|
      if @employer_liability_item.save
        format.html { redirect_to @employer_liability_item, notice: 'Employer liability item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @employer_liability_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @employer_liability_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employer_liability_items/1
  # PATCH/PUT /employer_liability_items/1.json
  def update
    respond_to do |format|
      if @employer_liability_item.update(employer_liability_item_params)
        format.html { redirect_to @employer_liability_item, notice: 'Employer liability item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @employer_liability_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employer_liability_items/1
  # DELETE /employer_liability_items/1.json
  def destroy
    @employer_liability_item.destroy
    respond_to do |format|
      format.html { redirect_to employer_liability_items_url }
      format.json { head :no_content }
    end
  end

  # POST /employer_liability_items/add_to_cart
  def add_to_cart
    @employer_liability_item = EmployerLiabilityItem.new(insurance_id: params[:insurance_id], business_nature: 1)
    @employer_liability_item.build_line_item(user_id: current_user.id)
    respond_to do |format|
      if @employer_liability_item.save
        format.html { redirect_to :back, notice: 'Employer liability insurance was added to cart.' }
        format.json { render action: 'show', status: :created, location: @employer_liability_item }
      else
        format.html { redirect_to :back, alert: 'Employer liability insurance was failed to add to cart.' }
        format.json { render json: @employer_liability_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employer_liability_item
      @employer_liability_item = EmployerLiabilityItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employer_liability_item_params
      params.require(:employer_liability_item).permit(:insurance_id, :business_nature, :manufacture_category, :bodily_injury_limit, :medical_expenses_limit, :litigation_costs_limit, :within_period_aggregate_limit, :deductibles, :each_accident_limit, :each_accident_bodily_injury_limit, :aggregate_limit, :property_deductibles, :employee_number, :effective_date, :termination_date, :line_item_attributes => [:user_id, :price, :quantity, :name, :telephone, :code_number, :enterprise_name, :province, :city, :district, :location, :zipcode, :lock_version], :insurance_business_attributes => [:name, :telephone, :code_number, :enterprise_name, :province, :city, :district, :location, :zipcode], :employer_liability_employees_attributes => [:id, :name, :title, :health, :_destroy])
    end
end
