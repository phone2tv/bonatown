class HealthInsurancesController < ApplicationController
  before_action :set_health_insurance, only: [:show, :edit, :update, :destroy]

  # GET /health_insurances
  # GET /health_insurances.json
  def index
    @health_insurances = HealthInsurance.all
  end

  # GET /health_insurances/1
  # GET /health_insurances/1.json
  def show
  end

  # GET /health_insurances/new
  def new
    @health_insurance = HealthInsurance.new
    @health_insurance.build_insurance
  end

  # GET /health_insurances/1/edit
  def edit
  end

  # POST /health_insurances
  # POST /health_insurances.json
  def create
    @health_insurance = HealthInsurance.new(health_insurance_params)

    respond_to do |format|
      if @health_insurance.save
        format.html { redirect_to @health_insurance, notice: 'Health insurance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @health_insurance }
      else
        format.html { render action: 'new' }
        format.json { render json: @health_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /health_insurances/1
  # PATCH/PUT /health_insurances/1.json
  def update
    respond_to do |format|
      if @health_insurance.update(health_insurance_params)
        format.html { redirect_to @health_insurance, notice: 'Health insurance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @health_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /health_insurances/1
  # DELETE /health_insurances/1.json
  def destroy
    @health_insurance.destroy
    respond_to do |format|
      format.html { redirect_to health_insurances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_health_insurance
      @health_insurance = HealthInsurance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def health_insurance_params
      params.require(:health_insurance).permit(:body, :insurance_attributes => [:title, :synopsis, :price, :workflow_state, :company_id, :profile_id, :profile_type])
    end
end
