require "test_helper"

class BucketlistTest < ActiveSupport::TestCase
  test "A Bucketlist is valid with a name" do
    bucketlist = Bucketlist.new(name: "main")

    assert bucketlist.valid?
    refute bucketlist.invalid?
  end

  test "a bucketlist can have many items" do
    bucketlist = Bucketlist.create(name: "Jeff")
    item_one = Item.create(name: "kill the boy")
    item_two = Item.create(name: "watch champions league final")

    bucketlist.items << item_one
    bucketlist.items << item_two

    assert_equal 2, bucketlist.items.count
  end
end
