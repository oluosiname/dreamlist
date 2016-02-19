require 'test_helper'

class Api::V1::BucketlistsControllerTest < ActionController::TestCase

  def create_user
    @controller = Api::V1::SessionsController.new
    user = User.new(
      name: "Olamide",
      email: "sname@examples.com",
      password: "sname"
    )
    user.save
  end

  def login
    login_params = { email: "sname@examples.com", password: "sname" }
    post :create, login_params
    assert_response :success
    the_response = JSON.parse(response.body)
    @token = the_response["token"]
    @controller = Api::V1::BucketlistsController.new
  end

  test "creates bucketlist for a logged in user" do
    create_user
    login
    @request.headers["Accept"] = "application/json"
    @request.headers["Authorization"] = "Token #{@token}"
    post :create, name: "Main bucketlist"
    assert_response 200
  end

  # test "gets bucketlists for a logged in user" do
  #   login
  #   @request.headers["Accept"] = "application/json"
  #   @request.headers["Authorization"] = "Token #{@token}"
  #   get :index
  #   assert_response 200
  # end

end
