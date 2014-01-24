class EmployerLiabilityInsurancesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index, :show]

  before_action :set_employer_liability_insurance, only: [:show, :edit, :update, :destroy]

  # GET /employer_liability_insurances
  # GET /employer_liability_insurances.json
  def index
    @employer_liability_insurances = EmployerLiabilityInsurance.all
  end

  # GET /employer_liability_insurances/1
  # GET /employer_liability_insurances/1.json
  def show
  end

  # GET /employer_liability_insurances/new
  def new
    @employer_liability_insurance = EmployerLiabilityInsurance.new
  end

  # GET /employer_liability_insurances/1/edit
  def edit
  end

  # POST /employer_liability_insurances
  # POST /employer_liability_insurances.json
  def create
    @employer_liability_insurance = EmployerLiabilityInsurance.new(employer_liability_insurance_params)

    respond_to do |format|
      if @employer_liability_insurance.save
        format.html { redirect_to @employer_liability_insurance, notice: 'Accident insurance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @employer_liability_insurance }
      else
        format.html { render action: 'new' }
        format.json { render json: @employer_liability_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employer_liability_insurances/1
  # PATCH/PUT /employer_liability_insurances/1.json
  def update
    respond_to do |format|
      if @employer_liability_insurance.update(employer_liability_insurance_params)
        format.html { redirect_to @employer_liability_insurance, notice: 'Accident insurance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @employer_liability_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employer_liability_insurances/1
  # DELETE /employer_liability_insurances/1.json
  def destroy
    @employer_liability_insurance.destroy
    respond_to do |format|
      format.html { redirect_to employer_liability_insurances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employer_liability_insurance
      @employer_liability_insurance = EmployerLiabilityInsurance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employer_liability_insurance_params
      params.require(:employer_liability_insurance).permit(:title, :synopsis, :price, :aasm_state, :type, :company_id, :image, :target, :feature, :benefit)
    end
end
