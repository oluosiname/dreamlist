class Api::V1::SessionsController < ApplicationController

  skip_before_action :authenticate_user, only: :create

  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authenticate(session_params[:password])
      token = user.generate_auth_token
      render json: { notice: "Login successful", token: token }, status: 201
    else
      render json: { error: "Incorrect username/password" }, status: 401
    end
  end

  def destroy
    # Token.find_by_value(get_token).destroy
    render json: { notice: "You are now logged out" }, status: 200
  end

  def session_params
    params.permit(:email, :password)
  end
end
