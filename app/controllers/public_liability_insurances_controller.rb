class PublicLiabilityInsurancesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index, :show]
  before_action :set_public_liability_insurance, only: [:show, :edit, :update, :destroy]

  # GET /public_liability_insurances
  # GET /public_liability_insurances.json
  def index
    @public_liability_insurances = PublicLiabilityInsurance.all
  end

  # GET /public_liability_insurances/1
  # GET /public_liability_insurances/1.json
  def show
  end

  # GET /public_liability_insurances/new
  def new
    @public_liability_insurance = PublicLiabilityInsurance.new
  end

  # GET /public_liability_insurances/1/edit
  def edit
  end

  # POST /public_liability_insurances
  # POST /public_liability_insurances.json
  def create
    @public_liability_insurance = PublicLiabilityInsurance.new(public_liability_insurance_params)

    respond_to do |format|
      if @public_liability_insurance.save
        format.html { redirect_to @public_liability_insurance, notice: 'Accident insurance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @public_liability_insurance }
      else
        format.html { render action: 'new' }
        format.json { render json: @public_liability_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /public_liability_insurances/1
  # PATCH/PUT /public_liability_insurances/1.json
  def update
    respond_to do |format|
      if @public_liability_insurance.update(public_liability_insurance_params)
      # format.html { redirect_to @public_liability_insurance, notice: 'Accident insurance was successfully updated.' }
        format.html { redirect_to insurances_url, notice: 'Public liability insurance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @public_liability_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /public_liability_insurances/1
  # DELETE /public_liability_insurances/1.json
  def destroy
    @public_liability_insurance.destroy
    respond_to do |format|
      format.html { redirect_to public_liability_insurances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public_liability_insurance
      @public_liability_insurance = PublicLiabilityInsurance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def public_liability_insurance_params
      params.require(:public_liability_insurance).permit(:title, :synopsis, :price, :aasm_state, :type, :company_id, :image, :target, :feature, :benefit)
    end
end
