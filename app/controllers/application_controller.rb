class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  #around_filter :wrap_in_transaction
  before_filter :authenticate_user! , unless: :devise_controller?

  before_filter :clear_thread_context
  before_filter :set_thread_context

  def wrap_in_transaction
    begin
      ActiveRecord::Base.transaction do
        yield
      end
    rescue ActiveRecord::RecordNotFound => e
      message="Your query fetched no results. " + e.message
      flash.now[:error]= message
      @error = message
      log_error e
      render '/home/index'
    rescue ActiveRecord::RecordNotUnique => e
      message="Duplicate Data entered! "
      flash.now[:error] = message + e.message
      @error = message
      log_error e
      render '/home/index'
    rescue ActiveRecord::ActiveRecordError => e
      message="Record Not Found : " + e.message
      flash.now[:error]= message
      @error = message
      log_error e
      render '/home/index'
    rescue NoMethodError => e
      message="Attempt to access a page that does not exist. " + e.message
      flash.now[:error]= message
      @error = message
      log_error e
      render '/home/index'
    rescue ActionView::Template::Error => e
      message="Some error occurred while loading the page. "+ e.message
      flash.now[:error]= message
      @error = message
      log_error e
      render '/home/index'
    rescue Exception => e
      message = "Technical Error! " + e.message
      @error = message
      flash.now[:error] = message
      log_error e
      render '/home/index'
    end
  end


  def clear_thread_context
    Thread.current[:current_user] = nil
  end

  def set_thread_context
    return if ['confirmations', 'sessions', 'registrations', 'passwords'].include? self.controller_name

    if user_signed_in?
      User.current_user= current_user

      puts "======================================="
      puts current_user.roles.map(&:name)
      puts "======================================="

    end

  end


  #uncomment this to rescue can can exceptions
  #rescue_from CanCan::AccessDenied do |exception|
  #  redirect_to root_url, :alert => exception.message
  #end



  protected
    def authenticate_user!
      if user_signed_in?
        super
      else
        flash[:error] = "Please Log in first!"
        redirect_to :new_user_session
      end
    end

    def log_error e
      logger.error "Error" + e.message
      e.backtrace.each do |line|
        logger.error line
      end
    end
    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first,:last, :email, :password) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first,:last, :email, :password, :current_password, :is_female, :date_of_birth) }
    end
end
