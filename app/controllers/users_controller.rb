class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index, :show]

# before_action :set_user, only: [:show, :edit, :update, :destroy, :upload_gravatar, :edit_gravatar, :update_gravatar, :edit_bio, :edit_aboutme, :edit_tags, :edit_password, :update_password]
  before_action :set_user, except: [:index]

# before_action :authorize_user!

  # GET /users
  # GET /users.json
  def index
    @users = User.all
#   @users = User.all.paginate(:page => params[:page], :per_page => 16)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1
  # GET /users/1.json
  def edit
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
    # if @user.profile.update(admin_profile_params)
      if update_profile
        format.html { redirect_to @user, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def authorize_user!
      user = @user.nil? ? User.new : @user
      unless can? params[:action].to_sym, user
        redirect_to root_path, alert: 'You have no permission to access this page.'
      end
    end

    def update_profile
      return @user.profile.update(admin_profile_params) if @user.has_role? :admin
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_profile_params
      params.require(:admin_profile).permit(:nickname, :realname, :aboutme)
    end
end
