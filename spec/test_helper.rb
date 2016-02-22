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

  def create_bucketlist
    @controller = Api::V1::BucketlistsController.new
    post :create, name: "testbucket1"
    msg = JSON.parse(response.body)
    @bucketlist = Bucketlist.find(msg["bucketlist"]["id"])

    post :create, name: "mainbucket2"
    msg = JSON.parse(response.body)
    @second_bucketlist = Bucketlist.find(msg["bucketlist"]["id"])
    @controller = Api::V1::ItemsController.new
  end
end
