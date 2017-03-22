class SecretCodeController < ApplicationController
	authorize_resource :only => [:create]
	def index
    	@secret_codes = SecretCodes.all
    	# @secret_codes = SecretCodes.includes(:user).all
	end

	def create
		strong_params = secret_code_params
		SecretCodes.create_codes strong_params[:count].to_i
		flash[:now] = params[:count]+" secret code created successfully"
		redirect_to :back
	end	

	private
	
	def secret_code_params
    	params.permit(:count)
 	end

end
