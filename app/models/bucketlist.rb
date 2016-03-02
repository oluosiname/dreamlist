class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :name, presence: true, uniqueness: true
  before_create :format_params

  scope(
    :search,
    lambda do |q|
      if q
        where("lower(name) like ?", "%#{q.downcase}%")
      else
        all
      end
    end
  )

  scope(
    :by_page,
    lambda do |limit, offset|
      offset(offset).limit(limit)
    end
  )

  private

  def format_params
    name.downcase!
  end
end
