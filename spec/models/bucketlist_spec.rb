require "rails_helper"

RSpec.describe Bucketlist, type: :model do

  before :all do
    User.destroy_all
    Bucketlist.destroy_all
  end
  it "has a valid factory" do
    expect(build(:bucketlist)).to be_valid
  end

  let(:bucketlist) { build(:bucketlist) }
  let(:user) { build(:user) }

  describe "instance method calls" do
    context "when I call the instance methods" do
      it { expect(bucketlist).to respond_to(:name) }
      it { expect(bucketlist).to respond_to(:user_id) }
    end
  end

  describe "instance method calls" do
    context "when I call the instance methods" do
      it { expect(bucketlist).to respond_to(:name) }
      it { expect(bucketlist).to respond_to(:user_id) }
    end
  end
end
