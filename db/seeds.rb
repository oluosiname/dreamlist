User.destroy_all
Bucketlist.destroy_all
Item.destroy_all

5.times do
  User.create(
    name: Faker::Name.name,
    password: "sname",
    email: Faker::Internet.safe_email
  )
end

users = User.all
100.times do |n|
  Bucketlist.create(
    name: "Bucketlist #{n}",
    user_id: users.sample.id
  )
end

200.times do
  Item.create(
    name: Faker::Company.bs,
    bucketlist_id: Bucketlist.all.sample.id,
  )
end
