require "test_helper"

class Api::V1::BucketlistsControllerTest < ActionController::TestCase
  def create_user
    @controller = Api::V1::SessionsController.new
    @user = User.new(
      name: "Olamide",
      email: "sname@examples.com",
      password: "sname"
    )
    @user.save
  end

  def login
    login_params = { email: "sname@examples.com", password: "sname" }
    post :create, login_params
    assert_response :success
    msg = JSON.parse(response.body)
    @token = msg["token"]
    @controller = Api::V1::BucketlistsController.new
  end

  test "creates bucketlist for a logged in user" do
    create_user
    login
    assert_difference("@user.bucketlists.count", 1) do
      @request.headers["Accept"] = "application/json"
      @request.headers["Authorization"] = "Token #{@token}"
      post :create, name: "Main bucketlist"

      bucketlist = JSON.parse(response.body)
      assert_response 200
      assert_equal "Main bucketlist", bucketlist["name"]
    end
    @user.destroy
  end

  test "does not create bucketlist with empty name" do
    create_user
    login
    @request.headers["Accept"] = "application/json"
    @request.headers["Authorization"] = "Token #{@token}"
    post :create

    msg = JSON.parse(response.body)
    assert_response 422
    assert_equal ["can't be blank"], msg["name"]
    assert_equal 0, @user.bucketlists.count
    @user.destroy
  end
end
