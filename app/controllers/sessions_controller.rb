# This is where we create (aka login) and destroy (aka logout) sessions.

class SessionsController < ApplicationController
	def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else 
      redirect_to '/login'
    end
  end

  def destroy
    # session[:user_id] = nil
		session.delete(:user_id)
    redirect_to '/login'
  end
end
