require "rails_helper"

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  let(:user) { build(:user) }

  describe "instance method calls" do
    context "when I call the instance methods" do
      it { expect(user).to respond_to(:name) }
      it { expect(user).to respond_to(:email) }
      it { expect(user).to respond_to(:generate_auth_token) }
    end
  end
end
