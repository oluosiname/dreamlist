class ApplicationController < ActionController::API
  include ActionController::Serialization
  
  before_filter :set_cors
  before_action :authenticate_user, except: [:root]

  attr_reader :current_user

  def authenticate_user
    if decoded_auth_token && user_token?
      @current_user = User.find_by(id: decoded_auth_token["user_id"])
    else
      render json: { error: "Unauthorized access" }, status: 401
    end
  end

  def decoded_auth_token
    AuthToken.decode get_token
  end

  def get_token
    if request.headers["Authorization"].present?
      request.headers["Authorization"].split(" ").last
    end
  end

  def user_token?
    User.find_by(token: get_token)
  end
  
  def set_cors
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email'
  end
  
  def cors_preflight_check
      request.headers['Access-Control-Allow-Origin'] = '*'
      request.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
      request.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token, Auth-Token, Email'
      request.headers['Access-Control-Max-Age'] = '1728000'  
      render :text => '', :content_type => 'text/plain'
  end
end
