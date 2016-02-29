module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_user, only: :create

      def create
        user = User.find_by(email: session_params[:email])

        if user && user.authenticate(session_params[:password])
          token = user.generate_auth_token
          user.update_attributes token: token
          render json: { notice: "Login successful", token: token }, status: 201
        else
          render json: { error: "Incorrect username/password" }, status: 401
        end
      end

      def destroy
        current_user.update_attributes token: nil
        render json: { notice: "You are now logged out" }, status: 200
      end

      def session_params
        params.permit(:email, :password)
      end
    end
  end
end
