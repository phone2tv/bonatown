class AccidentInsurancesController < ApplicationController
  before_action :set_accident_insurance, only: [:show, :edit, :update, :destroy]

  # GET /accident_insurances
  # GET /accident_insurances.json
  def index
    @accident_insurances = AccidentInsurance.all
  end

  # GET /accident_insurances/1
  # GET /accident_insurances/1.json
  def show
  end

  # GET /accident_insurances/new
  def new
    @accident_insurance = AccidentInsurance.new
  end

  # GET /accident_insurances/1/edit
  def edit
  end

  # POST /accident_insurances
  # POST /accident_insurances.json
  def create
    @accident_insurance = AccidentInsurance.new(accident_insurance_params)

    respond_to do |format|
      if @accident_insurance.save
        format.html { redirect_to @accident_insurance, notice: 'Accident insurance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @accident_insurance }
      else
        format.html { render action: 'new' }
        format.json { render json: @accident_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accident_insurances/1
  # PATCH/PUT /accident_insurances/1.json
  def update
    respond_to do |format|
      if @accident_insurance.update(accident_insurance_params)
        format.html { redirect_to @accident_insurance, notice: 'Accident insurance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @accident_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accident_insurances/1
  # DELETE /accident_insurances/1.json
  def destroy
    @accident_insurance.destroy
    respond_to do |format|
      format.html { redirect_to accident_insurances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accident_insurance
      @accident_insurance = AccidentInsurance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accident_insurance_params
      params.require(:accident_insurance).permit(:title, :synopsis, :price, :aasm_state, :type, :company_id, :image, :target, :feature, :benefit)
    end
end
