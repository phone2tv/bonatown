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
end
