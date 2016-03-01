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
      create_bucketlist

      post :create, bucketlist_id: @bucketlist.id, name: "testitem1"

      expect(@bucketlist.items.count).to eq(1)
      expect(response.status).to eq(200)
    end

    it "does not create an item without a name" do
      login
      create_bucketlist

      post :create, bucketlist_id: @bucketlist.id, name: ""
      msg = JSON.parse(response.body)

      expect(@bucketlist.items.count).to eq(0)
      expect(msg["name"]).to eq ["can't be blank"]
    end

    it "does not add item if bucketlist does not exist" do
      login
      create_bucketlist

      post :create, bucketlist_id: 0, name: "testitem1"
      msg = JSON.parse(response.body)

      expect(@bucketlist.items.count).to eq(0)
      expect(msg["error"]).to eq("Bucketlist does not exist")
    end
  end

  context "update item" do
    it "updates an item with valid params" do
      login
      create_bucketlist

      post :create, bucketlist_id: @bucketlist.id, name: "testitem1"
      msg = JSON.parse(response.body)
      item = Item.find(msg["item"]["id"])

      post :update, bucketlist_id: @bucketlist.id,
                    name: "changed",
                    id: item.id,
                    done: true
      msg = JSON.parse(response.body)
      item = Item.find(msg["item"]["id"])

      expect(item.name).to eq("changed")
      expect(item.done).to be true
      expect(response.status).to eq(200)
    end

    it "does not update an item if it does not belong to bucketlist" do
      login
      create_bucketlist

      post :create, bucketlist_id: @bucketlist.id, name: "testitem1"
      msg = JSON.parse(response.body)
      item = Item.find(msg["item"]["id"])

      post :update, bucketlist_id: @second_bucketlist.id,
                    name: "changedname",
                    id: item.id,
                    done: true
      msg = JSON.parse(response.body)

      expect(msg["error"]).to eq "Item does not exist in this bucketlist"
    end

    it "does not update item if bucketlist does not exist" do
      login
      create_bucketlist

      post :create, bucketlist_id: @bucketlist.id, name: "testitem1"
      msg = JSON.parse(response.body)
      item = Item.find(msg["item"]["id"])

      post :update, bucketlist_id: 0,
                    name: "changed",
                    id: item.id,
                    done: true
      msg = JSON.parse(response.body)

      expect(msg["error"]).to eq("Bucketlist does not exist")
      expect(response.status).to eq(404)
    end
  end

  context "delete an item" do
    it "deletes an existing item" do
      login
      create_bucketlist

      post :create, bucketlist_id: @bucketlist.id, name: "testitem1"
      msg = JSON.parse(response.body)
      item = Item.find(msg["item"]["id"])

      post :destroy, bucketlist_id: @bucketlist.id,
                     id: item.id
      msg = JSON.parse(response.body)

      expect(msg["notice"]).to eq("Item deleted")
      expect(response.status).to eq(200)
    end

    it "does not update an item if it does not belong to bucketlist" do
      login
      create_bucketlist

      post :create, bucketlist_id: @bucketlist.id, name: "testitem1"
      msg = JSON.parse(response.body)
      item = Item.find(msg["item"]["id"])

      post :destroy, bucketlist_id: @second_bucketlist.id,
                     id: item.id
      msg = JSON.parse(response.body)

      expect(msg["error"]).to eq "Item does not exist in this bucketlist"
    end

    it "does not delete item if bucketlist does not exist" do
      login
      create_bucketlist

      post :create, bucketlist_id: @bucketlist.id, name: "testitem1"
      msg = JSON.parse(response.body)
      item = Item.find(msg["item"]["id"])

      post :destroy, bucketlist_id: 0,
                     id: item.id
      msg = JSON.parse(response.body)

      expect(msg["error"]).to eq("Bucketlist does not exist")
      expect(response.status).to eq(404)
    end
  end
end
