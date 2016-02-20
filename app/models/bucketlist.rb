class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :name, presence: true, uniqueness: true

  scope :search, ->(q) { where(user_id: user_id) }

  scope(
    :search,
    lambda do |q|
      where("name = ?", q)
    end
  )
end
