class QuoterProfilesController < ApplicationController
# skip_before_filter :authenticate_user!, :only => [:show]

  before_action :set_quoter_profile, only: [:show, :edit, :update, :destroy]

  # GET /quoter_profiles/1
  # GET /quoter_profiles/1.json
  def show
  end

  # GET /quoter_profiles/new
  def new
    @profile = QuoterProfile.new
    @profile.build_user
  end

  # GET /quoter_profiles/1
  # GET /quoter_profiles/1.json
  def edit
  end

  # POST /quoter_profiles
  # POST /quoter_profiles.json
  def create
    @profile = QuoterProfile.new(quoter_profile_params)
    @profile.user.add_role :quoter
    respond_to do |format|
      if @profile.save
      # format.html { redirect_to @profile.user, notice: 'QuoterProfile was successfully created.' }
        format.html { redirect_to users_url }
        format.json { render action: 'show', status: :created, location: @profile.user }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quoter_profiles/1
  # PATCH/PUT /quoter_profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(quoter_profile_params)
      # format.html { redirect_to @profile.user, notice: 'Profile was successfully updated.' }
        format.html { redirect_to users_url }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quoter_profiles/1
  # DELETE /quoter_profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quoter_profile
      @profile = QuoterProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quoter_profile_params
      if params[:quoter_profile][:user_attributes][:password].blank? and params[:quoter_profile][:user_attributes][:password_confirmation].blank?
        params[:quoter_profile][:user_attributes].delete :password
        params[:quoter_profile][:user_attributes].delete :password_confirmation
      end
      params.require(:quoter_profile).permit(:name, :user_attributes => [:username, :email, :password, :password_confirmation, :name, :card_type, :card_no, :birthday, :gender, :english_name, :mobile, :telephone, :province, :city, :district, :location])
    end
end
