class Item < ActiveRecord::Base
  belongs_to :bucketlist

  validates :name, presence: true
  before_create :format_params

  private

  def format_params
    name.downcase!
  end
end
