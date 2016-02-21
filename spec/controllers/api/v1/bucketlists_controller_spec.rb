require "rails_helper"
require "test_helper.rb"
RSpec.describe Api::V1::BucketlistsController, type: :controller do
  include TestHelper
  before(:each) do
    User.destroy_all
    #Bucketlist.destroy_all
    @user = create(:user)
    @bucketlist = create(:bucketlist)
  end

  context "create bucketlist" do
    it "creates a bucketlist with valid name" do
      login

      post :create, name: "testbucket1"
      msg = JSON.parse(response.body)

      expect(@user.bucketlists.count).to eq(1)
      expect(msg["bucketlist"]["name"]).to eq("testbucket1")
      expect(response.status).to eq(200)
    end

    it "does not create a bucketlist without a name" do
      login

      post :create
      bucketlist = JSON.parse(response.body)

      expect(@user.bucketlists.count).to eq(0)
      expect(response.status).to eq(422)
    end
  end

  context "gets bucketlist for a user" do
    it "creates a bucketlist with valid name" do
      @bucketlist.user_id = @user.id
      @bucketlist.save
      login

      get :index
      msg = JSON.parse(response.body)

      expect(@user.bucketlists.count).to eq(1)
      expect(msg["bucketlists"][0]["name"]).to eq(@bucketlist.name)
      expect(response.status).to eq(200)
    end
  end

  context "get bucketlists for a user" do
    it "gets all bucketlists for a user" do
      @bucketlist.user_id = @user.id
      @bucketlist.save
      login

      get :index
      msg = JSON.parse(response.body)

      expect(msg["bucketlists"][0]["name"]).to eq(@bucketlist.name)
      expect(response.status).to eq(200)
    end
  end

  context "gets a bucketlist for a user" do
    it "gets a particular bucketlist if it exist" do
      @bucketlist.user_id = @user.id
      @bucketlist.save
      login

      get :show, id: @bucketlist.id
      msg = JSON.parse(response.body)

      expect(msg["bucketlist"]["name"]).to eq(@bucketlist.name)
      expect(response.status).to eq(200)
    end

    it "gives error if bucketlist does not exist" do
      @bucketlist.user_id = @user.id
      @bucketlist.save
      login

      get :show, id: 0
      msg = JSON.parse(response.body)

      expect(msg["error"]).to eq("No such Bucketlist found")
      expect(response.status).to eq(404)
    end
  end

  context "destroy bucketlist" do
    it "destroys bucketlist for a user" do
      @bucketlist.user_id = @user.id
      @bucketlist.save
      login

      post :destroy, id: @bucketlist.id
      msg = JSON.parse(response.body)

      expect(msg["notice"]).to eq("Bucketlist deleted")
      expect(@user.bucketlists.count). to eq(0)
      expect(response.status).to eq(200)
    end

    it "gives error if bucketlist does not exist" do
      @bucketlist.user_id = @user.id
      @bucketlist.save
      login

      post :destroy, id: 0
      msg = JSON.parse(response.body)

      expect(msg["error"]).to eq("No such Bucketlist found")
      expect(response.status).to eq(404)
    end
  end

  context "updating a bucketlist" do
    it "updates an existing bucketlist" do
      @bucketlist.user_id = @user.id
      @bucketlist.save
      login

      post :update, id: @bucketlist.id, name: "newtestbucket1"
      msg = JSON.parse(response.body)

      expect(msg["bucketlist"]["name"]).to eq("newtestbucket1")
      expect(response.status).to eq(201)
    end

    it "gives error if bucketlist does not exist" do
      @bucketlist.user_id = @user.id
      @bucketlist.save
      login

      post :update, id: 0
      msg = JSON.parse(response.body)

      expect(msg["error"]).to eq("No such Bucketlist found")
      expect(response.status).to eq(404)
    end

    it "does not update without valid params" do
      @bucketlist.user_id = @user.id
      @bucketlist.save
      login

      post :update, id: @bucketlist.id, name: ""
      msg = JSON.parse(response.body)

      expect(msg["name"]).to eq ["can't be blank"]
      expect(response.status).to eq(400)
    end
  end
end
