class ManagerProfilesController < ApplicationController
# skip_before_filter :authenticate_user!, :only => [:show]

  before_action :set_manager_profile, only: [:show, :edit, :update, :destroy]

  # GET /manager_profiles/1
  # GET /manager_profiles/1.json
  def show
  end

  # GET /manager_profiles/new
  def new
    @profile = ManagerProfile.new
    @profile.build_user
  end

  # GET /manager_profiles/1
  # GET /manager_profiles/1.json
  def edit
  end

  # POST /manager_profiles
  # POST /manager_profiles.json
  def create
    @profile = ManagerProfile.new(manager_profile_params)
    @profile.user.add_role :manager
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile.user, notice: 'ManagerProfile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile.user }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manager_profiles/1
  # PATCH/PUT /manager_profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(manager_profile_params)
        format.html { redirect_to @profile.user, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manager_profiles/1
  # DELETE /manager_profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manager_profile
      @profile = ManagerProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manager_profile_params
      if params[:manager_profile][:user_attributes][:password].blank? and params[:manager_profile][:user_attributes][:password_confirmation].blank?
        params.require(:manager_profile).permit(:name, :user_attributes => [:username, :email])
      else
        params.require(:manager_profile).permit(:name, :user_attributes => [:username, :email, :password, :password_confirmation])
      end
    end
end
