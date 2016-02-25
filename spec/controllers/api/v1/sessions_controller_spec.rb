require "rails_helper"

RSpec.describe Api::V1::SessionsController, type: :controller do
  before(:all) do
    User.destroy_all
  end

  before(:each) do
    @user = create(:user)
  end

  context "user login" do
    it "Logs in a valid user" do
      user_params = {
        email: @user.email,
        password: @user.password
      }

      post :create, user_params
      msg = JSON.parse(response.body)
      current_user = User.find_by_id(@user.id)

      expect(response.status).to eq(201)
      expect(current_user.token.nil?).to be false
      expect(msg["notice"]).to eq "Login successful"
    end

    it "Logs in a valid user" do
      user_params = {
        email: @user.email,
        password: "thief"
      }

      post :create, user_params
      msg = JSON.parse(response.body)

      expect(response.status).to eq(401)
      expect(msg["error"]).to eq "Incorrect username/password"
    end
  end

  context "Logout" do
    it "Logs out a user" do
      post :create, email: @user.email, password: @user.password
      current_user = User.find_by_id(@user.id)

      @request.headers["Accept"] = "application/json"
      @request.headers["Authorization"] = "Token #{current_user.token}"
      get :destroy
      msg = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(msg["notice"]).to eq "You are now logged out"
    end
  end

  context "unauthorized access without token" do
    it "throws error" do
      @request.headers["Accept"] = "application/json"
      @request.headers["Authorization"] = "Token hhh }"
      get :destroy
      msg = JSON.parse(response.body)

      expect(response.status).to eq(401)
      expect(msg["error"]).to eq "Unauthorized access"
    end
  end
end
