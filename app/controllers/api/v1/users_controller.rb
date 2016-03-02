module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user, only: :create

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: 201
        else
          render json: @user.errors, status: 400
        end
      end

      private

      def user_params
        params.permit(:name, :email, :password)
      end
    end
  end
end
