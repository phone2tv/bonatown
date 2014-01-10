class AdminProfilesController < ApplicationController
# skip_before_filter :authenticate_user!, :only => [:show]

  before_action :set_admin_profile, only: [:show, :edit, :update, :destroy]

  # GET /admin_profiles/1
  # GET /admin_profiles/1.json
  def show
  end

  # GET /admin_profiles/new
  def new
    @profile = AdminProfile.new
    @profile.build_user
  end

  # GET /admin_profiles/1
  # GET /admin_profiles/1.json
  def edit
  end

  # POST /admin_profiles
  # POST /admin_profiles.json
  def create
    @profile = AdminProfile.new(admin_profile_params)
    @profile.user.add_role :admin
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile.user, notice: 'AdminProfile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile.user }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_profiles/1
  # PATCH/PUT /admin_profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(admin_profile_params)
        format.html { redirect_to @profile.user, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_profiles/1
  # DELETE /admin_profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_profile
      @profile = AdminProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_profile_params
      if params[:admin_profile][:user_attributes][:password].blank? and params[:admin_profile][:user_attributes][:password_confirmation].blank?
        params.require(:admin_profile).permit(:name, :aboutme, :user_attributes => [:username, :email])
      else
        params.require(:admin_profile).permit(:name, :aboutme, :user_attributes => [:username, :email, :password, :password_confirmation])
      end
    end
end
