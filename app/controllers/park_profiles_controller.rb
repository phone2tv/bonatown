class ParkProfilesController < ApplicationController
# skip_before_filter :authenticate_user!, :only => [:show]

  before_action :set_park_profile, only: [:show, :edit, :update, :destroy]

  # GET /park_profiles/1
  # GET /park_profiles/1.json
  def show
  end

  # GET /park_profiles/new
  def new
    @profile = ParkProfile.new
    @profile.build_user
  end

  # GET /park_profiles/1
  # GET /park_profiles/1.json
  def edit
  end

  # POST /park_profiles
  # POST /park_profiles.json
  def create
    @profile = ParkProfile.new(park_profile_params)
    @profile.user.add_role :park
    respond_to do |format|
      if @profile.save
      # format.html { redirect_to @profile.user, notice: 'ParkProfile was successfully created.' }
        format.html { redirect_to users_url }
        format.json { render action: 'show', status: :created, location: @profile.user }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /park_profiles/1
  # PATCH/PUT /park_profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(park_profile_params)
      # format.html { redirect_to @profile.user, notice: 'Profile was successfully updated.' }
        format.html { redirect_to users_url }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /park_profiles/1
  # DELETE /park_profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_park_profile
      @profile = ParkProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def park_profile_params
      if params[:park_profile][:user_attributes][:password].blank? and params[:park_profile][:user_attributes][:password_confirmation].blank?
        params[:park_profile][:user_attributes].delete :password
        params[:park_profile][:user_attributes].delete :password_confirmation
      end
      params.require(:park_profile).permit(:name, :park_name, :location, :company_id, :user_attributes => [:username, :email, :password, :password_confirmation, :name, :card_type, :card_no, :birthday, :gender, :english_name, :mobile, :telephone, :province, :city, :district, :location])
    end
end
