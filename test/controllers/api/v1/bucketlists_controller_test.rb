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
    @request.headers["Accept"] = "application/json"
    @request.headers["Authorization"] = "Token #{@token}"
  end

  test "creates bucketlist for a logged in user" do
    create_user
    login
    assert_difference("@user.bucketlists.count", 1) do
      post :create, name: "Main bucketlist"

      bucketlist = JSON.parse(response.body)
      assert_response 200
      assert_equal "Main bucketlist", bucketlist["name"]

      @request.headers["Authorization"] = "Token kk"
      post :create, name: "Main bucketlist"

      msg = JSON.parse(response.body)
      assert_response 401
      assert_equal "Unauthorized access", msg["error"]
    end
    @user.destroy
  end

  test "does not create bucketlist with empty name" do
    create_user
    login
    post :create

    msg = JSON.parse(response.body)
    assert_response 422
    assert_equal ["can't be blank"], msg["name"]
    assert_equal 0, @user.bucketlists.count
    @user.destroy
  end


  test "gets bucketlists for a logged in user" do
    create_user
    login
    post :create, name: "Main bucketlist"
    post :create, name: "Main bucketlist2"
    get :index

    bucketlists = JSON.parse(response.body)
    assert_equal 2, bucketlists.count
    assert_response 200
  end

  test "gets existing single bucketlist for a logged in user" do
    create_user
    login
    post :create, name: "Main bucketlist"
    bucketlist = JSON.parse(response.body)
    get :show, id:bucketlist["id"]

    bucketlist = JSON.parse(response.body)
    assert_equal "Main bucketlist", bucketlist["name"]
    assert_response 200

    get :show, id: 0

    msg = JSON.parse(response.body)
    assert_equal "No such Bucketlist found", msg["error"]
    assert_response 404
  end

  test "deletes a bucketlist" do
    create_user
    login
    post :create, name: "Main bucketlist"
    bucketlist = JSON.parse(response.body)
    post :destroy, id:bucketlist["id"]

    msg = JSON.parse(response.body)
    assert_equal "Bucketlist deleted", msg["notice"]
    assert_response 200

    post :destroy, id: 0

    msg = JSON.parse(response.body)
    assert_equal "No such Bucketlist found", msg["error"]
    assert_response 404
  end
end
