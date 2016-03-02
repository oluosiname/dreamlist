require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:all) do
    User.destroy_all
  end

  context "Create User" do
    it "saves a user with valid params" do
      user_params = {
        name: "Olamide",
        email: "sname@example.com",
        password: "sname"
      }

      post :create, user_params
      msg = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(msg["user"]["name"]).to eq "olamide"
    end

    it "does not save a user without a missing param" do
      user_params = {
        email: "sname@example.com",
        password: "sname"
      }

      post :create, user_params
      error = JSON.parse(response.body)

      expect(response.status).to eq(400)
      expect(error["name"]).to eq ["can't be blank"]
    end
  end
end
