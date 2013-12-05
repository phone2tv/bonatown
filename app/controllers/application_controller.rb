class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # set up user authentiation with devise
  before_filter :authenticate_user!

  before_filter :set_locale

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:username, :terms_of_service]
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

  def can?(action, object, parent=nil)
    user = current_user

    if (object.is_a? User)
      if (action == :index or action == :show)
        return true
      elsif (user == object)
        return true
      else
        return false
      end
    end

    if (object.is_a? ActsAsTaggableOn::Tag)
      if (action == :index)
        return true
      else
        return false
      end
    end

    if (action == :top)
      return [Question, Answer, Comment].include?(object.class)
    elsif (action == :index)
      return [Question, Answer, Comment].include?(object.class)
    elsif (action == :show)
      return [Question, Answer, Comment].include?(object.class)
    elsif !user_signed_in?
      return false
    elsif (action == :new)
      if [Question, Answer].include?(object.class)
        return true
      elsif [Comment].include?(object.class)
        return parent.owned_by?(user) || user.can_addcomment?
      end
    elsif (action == :create)
      if [Question, Answer].include?(object.class)
        return true
      elsif [Comment].include?(object.class)
        return parent.owned_by?(user) || user.can_addcomment?
      end
    elsif (action == :destroy)
      return [Question, Answer, Comment].include?(object.class) && object.owned_by?(user)
    elsif (action == :edit)
      return [Question, Answer].include?(object.class) && object.owned_by?(user)
    elsif (action == :update)
      return [Question, Answer].include?(object.class) && object.owned_by?(user)
    elsif (action == :upvote)
      return [Question, Answer].include?(object.class) && !object.owned_by?(user) && user.can_upvote?
    elsif (action == :downvote)
      return [Question, Answer].include?(object.class) && !object.owned_by?(user) && user.can_downvote?
    elsif (action == :favorite)
      return [Question].include?(object.class)
    elsif (action == :read)
      return [Question].include?(object.class)
    elsif (action == :accept)
      return [Answer].include?(object.class)
    else
      return false
    end
  end

  helper_method :can?
end
