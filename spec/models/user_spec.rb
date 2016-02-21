require "rails_helper"

RSpec.describe User, type: :model do
  # it "has a valid factory" do
  #   expect(build(:bucketlist)).to be_valid
  # end

  # let(:bucketlist) { build(:bucketlist) }

  # describe "instance method calls" do
  #   context "when I call the instance methods" do
  #     it { expect(bucketlist).to respond_to(:name) }
  #     it { expect(bucketlist).to respond_to(:user_id) }
  #   end
  # end

  # describe "ActiveModel Validations" do
  #   it { expect(bucketlist).to validate_presence_of(:name) }
  # end

  # describe "ActiveModel Association" do
  #   it { expect(bucketlist).to have_many(:items) }
  #   it { expect(bucketlist).to belong_to(:user) }
  # end

  # describe "Model scopes" do
  #   describe ".search" do
  #     it "searches and return the bucketlist that matches search param" do
  #       bucket = Bucketlist.create(name: "Sample Bucket", user_id: 1)
  #       expect(Bucketlist.search("Sample").last).to eq(bucket)
  #     end
  #   end

  #   describe ".by_current_user" do
  #     it "returns the bucketlist created by the current user" do
  #       bucket = Bucketlist.create(name: "Sample Bucket", user_id: 1)
  #       expect(Bucketlist.by_current_user(1).last).to eq(bucket)
  #     end
  #   end

  #   describe ".paginate" do
  #     it "returns the specified page and limit of the results" do
  #       bucket3 = Bucketlist.create(name: "Sample Bucket 3", user_id: 1)
  #       expect(Bucketlist.paginate(limit: 20, page: 1).last).to eq(bucket3)
  #     end
  #   end
  # end
end
