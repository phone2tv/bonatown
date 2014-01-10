class ModeratorProfilesController < ApplicationController
# skip_before_filter :authenticate_user!, :only => [:show]

  before_action :set_moderator_profile, only: [:show, :edit, :update, :destroy]

  # GET /moderator_profiles/1
  # GET /moderator_profiles/1.json
  def show
  end

  # GET /moderator_profiles/new
  def new
    @profile = ModeratorProfile.new
    @profile.build_user
  end

  # GET /moderator_profiles/1
  # GET /moderator_profiles/1.json
  def edit
  end

  # POST /moderator_profiles
  # POST /moderator_profiles.json
  def create
    @profile = ModeratorProfile.new(moderator_profile_params)
    @profile.user.add_role :moderator
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile.user, notice: 'ModeratorProfile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile.user }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moderator_profiles/1
  # PATCH/PUT /moderator_profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(moderator_profile_params)
        format.html { redirect_to @profile.user, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moderator_profiles/1
  # DELETE /moderator_profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moderator_profile
      @profile = ModeratorProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def moderator_profile_params
      if params[:moderator_profile][:user_attributes][:password].blank? and params[:moderator_profile][:user_attributes][:password_confirmation].blank?
        params.require(:moderator_profile).permit(:name, :user_attributes => [:username, :email])
      else
        params.require(:moderator_profile).permit(:name, :user_attributes => [:username, :email, :password, :password_confirmation])
      end
    end
end
