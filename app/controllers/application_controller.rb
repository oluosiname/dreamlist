class ApplicationController < ActionController::API
  before_action :authenticate_user, except: [:no_route, :root]

  attr_reader :current_user

  def authenticate_user
    if decoded_auth_token && user_token?
      @current_user = User.find(decoded_auth_token["user_id"])
    else
      render json: { error: "Unauthorized access" }, status: 401
    end
  end

  def decoded_auth_token
    AuthToken.decode(get_token)
  end

  def get_token
    if request.headers["Authorization"].present?
      request.headers["Authorization"].split(" ").last
    end
  end

  def user_token?
    User.find_by_token(get_token)
  end
end
