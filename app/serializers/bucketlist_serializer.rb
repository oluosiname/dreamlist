class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :date_created, :date_modified, :created_by

  has_many :items

  attributes

  def date_created
    object.created_at.strftime("%Y-%m-%d %l:%M:%S")
  end

  def date_modified
    object.updated_at.strftime("%Y-%m-%d %l:%M:%S")
  end

  def created_by
    object.user.name
  end
end
