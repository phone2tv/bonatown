class ElevatorsController < ApplicationController
  before_action :set_public_liability
  before_action :set_elevator, only: :destroy
  before_action :authorize_user!

  # GET /elevators/new
  def new
    @elevator = @public_liability.elevators.new

    respond_to do |format|
      format.html { redirect_to @public_liability, alert: 'just refresh this page' }
      format.js # default to render 'new.js.erb'
    end
  end

  # POST /elevators
  # POST /elevators.json
  def create
    @elevator = @public_liability.elevators.build(elevator_params)
    @elevator.user = current_user

    respond_to do |format|
      if @elevator.save
        notice_msg = "Successfully created elevator."
        format.html { redirect_to @public_liability, alert: notice_msg }
        format.js # default to render 'create.js.erb'
      else
        notice_msg = "Can't add empty elevator"
        format.html { redirect_to @public_liability, alert: notice_msg }
        format.js { render 'create_failed.js.erb' }
      end
    end
  end

  # PATCH/PUT /elevator/1
  # PATCH/PUT /elevator/1.json
  def destroy
    @elevator.destroy if @elevator.owned_by? current_user
    notice_msg = "Successfully destroyed elevator."

    respond_to do |format|
      format.html { redirect_to @public_liability, alert: notice_msg }
      format.js # default to render 'create.js.erb'
    end
  # redirect_to (@public_liability.is_a? Question) ? @public_liability : @public_liability.question
  # flash[:notice] = "Successfully destroyed elevator."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public_liability
      if params[:public_liability_id]
        @public_liability = PublicLiability.find_by(id: params[:public_liability_id])
      end

    # params.each do |name, value|
    #   if name =~ /(.+)_id$/
    #     return @public_liability = $1.classify.constantize.find(value)
    #   end
    # end
    end

    def set_elevator
      # set_public_liability callback will be called FIRSTLY.
      @elevator = @public_liability.elevators.find(params[:id])
    end

    def current_resource
      [@elevator, @public_liability]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def elevator_params
      params.require(:elevator).permit(:body)
    end

  # def authorize_user!
  #   elevator = @elevator.nil? ? Elevator.new : @elevator
  #   unless can? params[:action].to_sym, elevator, @public_liability
  #     redirect_to root_path, alert: 'You have no permission to access this page.'
  #   end
  # end
end
