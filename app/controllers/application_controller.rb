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
    response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'                                                                                                                                                                                                     
    response.headers['Access-Control-Allow-Credentials'] = 'true'                                                                                                                                                                                                                          
  end 

  def options                                                                                                                                                                                                                                                                              
    head :status => 200, :'Access-Control-Allow-Headers' => 'accept, content-type'                                                                                                                                                                                                         
  end

end
