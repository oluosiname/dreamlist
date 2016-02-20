require "test_helper"

class Api::V1::SessionsControllerTest < ActionController::TestCase
  def login
    @user = User.new(
      name: "Olamide",
      email: "sname@example.com",
      password: "sname"
    )
    @user.save
    login_params = { email: "sname@example.com", password: "sname" }
    post :create, login_params
  end

  test "logs in a valid user" do
    login
    msg = JSON.parse(response.body)

    assert_response :success
    assert_equal "Login successful", msg["notice"]
  end

  test "does not login with invalid details" do
    user = User.new(
      name: "Olamide",
      email: "sname@example.com",
      password: "sname"
    )
    login_params = { email: "sname@example.com", password: "thief" }
    user.save
    post :create, login_params

    assert_response 401
    user.destroy
  end

  test "logs out a logged in user" do
    login
    msg = JSON.parse(response.body)
    token = msg["token"]

    @request.headers["Accept"] = "application/json"
    @request.headers["Authorization"] = "Token #{token}"
    get :destroy

    assert_response :success
    msg = JSON.parse(response.body)
    assert_equal "You are now logged out", msg["notice"]
  end
end
