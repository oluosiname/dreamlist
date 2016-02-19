require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "A user is not valid without an email" do
    user = User.new(name: "Sname")

    assert user.invalid?
    refute user.valid?
  end

  test "A user is valid with a name and email" do
    user = User.new(name: "Sname", email: "sname@ex.com", password: "sname")

    assert user.valid?
  end

  test "A user is not valid without a password" do
    user = User.new(name: "Sname", email: "sname@ex.com")

    assert user.invalid?
    refute user.valid?
  end

  test "A user is not valid without a proper email" do
    user = User.new(name: "Sname", email: "@ex.com", password: "sname")

    assert user.invalid?
    refute user.valid?
  end
end
