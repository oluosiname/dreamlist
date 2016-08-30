module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user, only: [:create, :test]

      def create
        @user = User.new(user_params)

        if @user.save
          token = @user.generate_auth_token
          @user.update_attributes token: token
          render json: { notice: "Account Created", token: token, user: @user.name }, status: 201
        else
          render json: @user.errors, status: 400
        end
      end
      
      def test
        hh = request.body
        render json: { notice: "This is the webhook" }, status: 200
      end

      private

      def user_params
        params.permit(:name, :email, :password)
      end
    end
  end
end
