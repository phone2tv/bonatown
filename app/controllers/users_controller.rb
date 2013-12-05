class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:home, :index, :show]

  before_action :set_user, only: [:show, :edit, :update, :destroy]
# before_action :set_user, except: [:home, :index, :new, :create_user, :create_moderator, :new_admin, :create_admin, :new_manager, :create_manager, :new_quoter, :create_quoter]

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

  # GET /users/new
  def new
    @user = User.new
    @role_type = params[:role]
    redirect_to root_path, notice: 'User ROLE is not specifyied.' if @role_type.nil?
  end

  # GET /users/new_admin
  def new_admin
    @user = User.new
  end

  # GET /users/new_manager
  def new_manager
    @user = User.new
  end

  # GET /users/1
  # GET /users/1.json
  def edit
  end

  # POST /users
  # POST /users.json
  def create_user
    @user = User.new(user_params)
    @role_type = params[:role]
    role_profile = (@role_type.capitalize + 'Profile').constantize
    @user.add_role @role_type.to_sym
    @user.profile = role_profile.new(name: 'FullName')
    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_user_path(@user), notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create_admin
    @user = User.new(user_params)
    @user.add_role :admin
    @user.profile = AdminProfile.new(admin_profile_params)
  # @profile = AdminProfile.new(admin_profile_params)
  # @profile = AdminProfile.new(admin_params)
    respond_to do |format|
    # if @user.save
      if @user.valid? and @user.profile.valid? and @user.save
        format.html { redirect_to @user, notice: 'Admin was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new_admin' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create_moderator
    @user = User.new(user_params)
    @user.add_role :moderator
    @user.profile = ModeratorProfile.new(name: 'Realname')
  # profile = ModeratorProfile.new(name: 'Realname', user: @user)
    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_user_path(@user), notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create_manager
    @user = User.new(user_params)
    @user.add_role :manager
    @user.profile = ManagerProfile.new(manager_profile_params)
    respond_to do |format|
    # if @user.save
      if @user.valid? and @user.profile.valid? and @user.save
        format.html { redirect_to @user, notice: 'Manager was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new_manager' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if update_profile
        format.html { redirect_to @user, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
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
      return @user.profile.update(moderator_profile_params) if @user.has_role? :moderator
      return @user.profile.update(manager_profile_params) if @user.has_role? :manager
      return @user.profile.update(quoter_profile_params) if @user.has_role? :quoter
      return @user.profile.update(park_profile_params) if @user.has_role? :park
      return @user.profile.update(customer_profile_params) if @user.has_role? :customer
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def admin_params
      params.require(:profile).permit(:name, :aboutme)
    # params.require(:user).permit(:username, :email, :password, :password_confirmation, :nickname, :name, :aboutme)
    end

    def admin_profile_params
      params.require(:admin_profile).permit(:name, :aboutme)
    end

    def moderator_profile_params
      params.require(:moderator_profile).permit(:name)
    end

    def manager_profile_params
      params.require(:manager_profile).permit(:name)
    end

    def quoter_profile_params
      params.require(:quoter_profile).permit(:name)
    end

    def park_profile_params
      params.require(:park_profile).permit(:name)
    end

    def customer_profile_params
      params.require(:customer_profile).permit(:name)
    end
end
