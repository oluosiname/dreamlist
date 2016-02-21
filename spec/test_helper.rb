module TestHelper
  def login
    old_controller = @controller
    @controller = Api::V1::SessionsController.new
    post :create, email: @user.email, password: @user.password
    msg = JSON.parse(response.body)
    @token = msg["token"]
    @controller = old_controller
    @request.headers["Accept"] = "application/json"
    @request.headers["Authorization"] = "Token #{@token}"
  end
end
