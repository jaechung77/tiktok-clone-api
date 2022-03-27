class SessionsController < ApplicationController

  def omniauth
  	@user = User.from_omniauth(request.env["omniauth.auth"])
		if user.valid?
			session[:user_id] = @user.id
			redirect_to user_path(user)
		else
			redirect_to '/login'
		end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end

end