class CustomerProfilesController < ApplicationController
# skip_before_filter :authenticate_user!, :only => [:show]

  before_action :set_customer_profile, only: [:show, :edit, :update, :destroy]

  # GET /customer_profiles/1
  # GET /customer_profiles/1.json
  def show
  end

  # GET /customer_profiles/new
  def new
    @profile = CustomerProfile.new
    @profile.build_user
  end

  # GET /customer_profiles/1
  # GET /customer_profiles/1.json
  def edit
  end

  # POST /customer_profiles
  # POST /customer_profiles.json
  def create
    @profile = CustomerProfile.new(customer_profile_params)
    @profile.user.add_role :customer
    respond_to do |format|
      if @profile.save
      # format.html { redirect_to @profile.user, notice: 'CustomerProfile was successfully created.' }
        format.html { redirect_to users_url }
        format.json { render action: 'show', status: :created, location: @profile.user }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_profiles/1
  # PATCH/PUT /customer_profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(customer_profile_params)
      # format.html { redirect_to @profile.user, notice: 'Profile was successfully updated.' }
        format.html { redirect_to users_url }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_profiles/1
  # DELETE /customer_profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_profile
      @profile = CustomerProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_profile_params
      if params[:customer_profile][:user_attributes][:password].blank? and params[:customer_profile][:user_attributes][:password_confirmation].blank?
        params[:customer_profile][:user_attributes].delete :password
        params[:customer_profile][:user_attributes].delete :password_confirmation
      end
      params.require(:customer_profile).permit(:name, :telephone, :code_number, :enterprise_name, :province_code, :city_code, :district_code, :location, :zipcode, :business_license, :park_profile_id, :user_attributes => [:username, :email, :password, :password_confirmation, :name, :card_type, :card_no, :birthday, :gender, :english_name, :mobile, :telephone, :province, :city, :district, :location])
    end
end
