class RegistrationsController < Devise::RegistrationsController
  def new
    offset = rand(SecretCodes.count)
    @secret_code = SecretCodes.offset(offset).first

    super
  end

  def create
    if params[:user][:secret_code] != params[:user][:actual_secret_code]
      flash[:error] =  "please enter correct security code"
      redirect_to :back
    else
      super
      email_id = params[:user][:email]
      created_user = User.where(:email=> email_id).first
      sc = SecretCodes.find_by_code params[:user][:actual_secret_code]
      if created_user.present? && sc.present?
          sc.assign_user_to_security_code(created_user.id)
      else
        raise ActiveRecord::Rollback, "Some error occurred. Please try again!"
      end

    end
  end

  def update
    super
  end
end