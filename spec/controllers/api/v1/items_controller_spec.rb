require "rails_helper"
require "test_helper.rb"
RSpec.describe Api::V1::ItemsController, type: :controller do
  include TestHelper
  before(:each) do
    @user = create(:user)
  end

  context "create item" do
    it "creates an item with valid name" do
      login
      @controller = Api::V1::BucketlistsController.new
      post :create, name: "testbucket1"
      msg = JSON.parse(response.body)
      bucketlist = Bucketlist.find(msg["bucketlist"]["id"])
      @controller = Api::V1::ItemsController.new

      post :create, bucketlist_id: bucketlist.id, name: "testitem1"
      msg = JSON.parse(response.body)

      expect(bucketlist.items.count).to eq(1)
      expect(response.status).to eq(200)
    end

    it "does not an item if bucketlist does not exist" do
      login
      @controller = Api::V1::BucketlistsController.new
      post :create, name: "testbucket1"
      msg = JSON.parse(response.body)
      bucketlist = Bucketlist.find(msg["bucketlist"]["id"])
      @controller = Api::V1::ItemsController.new

      post :create, bucketlist_id: 0, name: "testitem1"
      msg = JSON.parse(response.body)

      expect(bucketlist.items.count).to eq(0)
      expect(msg["error"]).to eq("Bucketlist does not exist")
    end
  end

end
