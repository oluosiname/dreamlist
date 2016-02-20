require 'test_helper'

class Api::V1::SessionsControllerTest < ActionController::TestCase
  test "logs in a valid user" do
    user = User.new(
      name: "Olamide",
      email: "sname@example.com",
      password: "sname"
    )
    user.save
    login_params = { email: "sname@example.com", password: "sname" }
    post :create, login_params
    assert_response :success
    user.destroy
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
end
