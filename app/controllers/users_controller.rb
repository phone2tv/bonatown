class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index, :show]

  before_action :set_user, only: [:show, :destroy]

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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :name, :card_type, :card_no, :birthday, :gender, :english_name, :mobile, :telephone, :province, :city, :district, :location)
    end
end
