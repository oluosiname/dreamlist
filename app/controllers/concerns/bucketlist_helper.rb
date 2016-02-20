module BucketlistHelper
  # extend ActiveSupport::Concerns
  def user_bucket(id)
    current_user.bucketlists.find_by_id(id)
  end

  def user_buckets
    current_user.bucketlists
  end
end
