require "test_helper"
class Api::V1::UsersControllerTest < ActionController::TestCase
  test "create can create a user" do
    assert_difference("User.count", 1) do
      user_params = {
        name: "Olamide",
        email: "sname@example.com",
        password: "sname"
      }

      post :create, user_params
      user = JSON.parse(response.body)

      assert_equal "Olamide", user["name"]
      assert_equal "sname@example.com", user["email"]
    end
  end

  test "does not create a user without required params" do
    assert_difference("User.count", 0) do
      user_params = {
        name: "Olamide",
        password: "sname"
      }

      post :create, user_params
    end
  end
end
