class ProductLiabilityInsurancesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index, :show]
  before_action :set_product_liability_insurance, only: [:show, :edit, :update, :destroy]

  # GET /product_liability_insurances
  # GET /product_liability_insurances.json
  def index
    @product_liability_insurances = ProductLiabilityInsurance.all
  end

  # GET /product_liability_insurances/1
  # GET /product_liability_insurances/1.json
  def show
  end

  # GET /product_liability_insurances/new
  def new
    @product_liability_insurance = ProductLiabilityInsurance.new
  end

  # GET /product_liability_insurances/1/edit
  def edit
  end

  # POST /product_liability_insurances
  # POST /product_liability_insurances.json
  def create
    @product_liability_insurance = ProductLiabilityInsurance.new(product_liability_insurance_params)

    respond_to do |format|
      if @product_liability_insurance.save
        format.html { redirect_to @product_liability_insurance, notice: 'Accident insurance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product_liability_insurance }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_liability_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_liability_insurances/1
  # PATCH/PUT /product_liability_insurances/1.json
  def update
    respond_to do |format|
      if @product_liability_insurance.update(product_liability_insurance_params)
      # format.html { redirect_to @product_liability_insurance, notice: 'Accident insurance was successfully updated.' }
        format.html { redirect_to insurances_url, notice: 'Product liability insurance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product_liability_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_liability_insurances/1
  # DELETE /product_liability_insurances/1.json
  def destroy
    @product_liability_insurance.destroy
    respond_to do |format|
      format.html { redirect_to product_liability_insurances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_liability_insurance
      @product_liability_insurance = ProductLiabilityInsurance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_liability_insurance_params
      params.require(:product_liability_insurance).permit(:title, :synopsis, :price, :aasm_state, :type, :company_id, :image, :target, :feature, :benefit)
    end
end
