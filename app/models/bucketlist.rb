class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :name, presence: true, uniqueness: true

  scope(
    :search,
    lambda do |q|
      if q
        where("name like ?", "%#{q}%")
      else
        all
      end
    end
  )

  scope(
    :by_page,
    lambda do |page, lim,offset|
      offset(offset).limit(lim.to_i)
    end
  )
end
