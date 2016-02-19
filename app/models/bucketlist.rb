class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :name, presence: true, uniqueness: true

  scope :by_user, ->(user_id) { where(user_id: user_id) }
end
