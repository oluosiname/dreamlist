require "rails_helper"
require "test_helper.rb"

RSpec.describe Bucketlist, type: :model do
  include TestHelper
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

  describe "scope calls" do
    it "search for bucketlist by parameter" do
      bucketlist = create(:bucketlist)
      bucketlists = Bucketlist.search("Bucketlist1")
      expect(bucketlists).to include(bucketlist)
    end
  end
end
