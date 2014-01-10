class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  # set up user authentiation with devise
  before_filter :authenticate_user!

  before_action :authorize_user!

  before_filter :set_locale

  private

  def current_cart
    current_user.create_cart if current_user.cart.nil?
    current_user.cart

#   Cart.find(session[:cart_id])
# rescue ActiveRecord::RecordNotFound
#   current_user.create_cart if current_user.cart.nil?
#   session[:cart_id] = current_user.cart.id
#   current_user.cart
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:username, :email, :terms_of_service]
    devise_parameter_sanitizer.for(:sign_in) << :username
    devise_parameter_sanitizer.for(:account_update) << :username

  # devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
  # devise_parameter_sanitizer.for(:sign_up) do |u|
  #   u.permit(:email, :password, :password_confirmation, :profile_attributes => [:name])
  #   u.permit!
  # end

  # devise_parameter_sanitizer.for(:account_update) do |u|
  #   u.permit(:email, :password, :password_confirmation, :current_password, :profile_attributes => [:name, :gravatar, :website, :location, :birthday, :aboutme, :id])
  # end
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def current_resource
    # method 1: set instance directly
    if params[:id].present?
      instance_name = "@#{controller_name.singularize}"
      instance_value = controller_name.classify.constantize.find_by(id: params[:id])
      instance_variable_set(instance_name, instance_value)
    end
  end

  def authorize_user!
    unless current_permission.allow?(controller_name, params[:action], current_resource)
      @msg = 'You are not authorized to access this page.'
      respond_to do |format|
        format.html { redirect_to :back, alert: @msg }
        format.js { render 'questions/vote_failed.js.erb' }
      end
    end
  end

  def can?(action, object, parent = nil)
    if parent.nil?
      current_permission.allow? object.class.to_s.tableize, action, object
    else
      current_permission.allow? object.class.to_s.tableize, action, [object, parent]
    end
  end

  def set_locale
    if params[:locale] and I18n.available_locales.include? params[:locale].to_sym
      I18n.locale = params[:locale]
    else
      if params[:locale].present?
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
      I18n.locale = I18n.default_locale
    end
  # I18n.locale = params[:locale] or I18n.default_locale
  end

  def default_url_options(options={})
  # logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

# delegate :allow?, to: :current_permission
# helper_method :allow?

  helper_method :can?
  helper_method :current_cart
end
