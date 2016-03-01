module BucketlistHelper
  def user_bucket(id)
    current_user.bucketlists.find_by(id: id)
  end

  def user_buckets
    current_user.bucketlists
  end

  def set_limit(limit)
    @limit = limit || 20
    @limit.to_i > 100 ? 100 : @limit.to_i
  end

  def set_offset(page)
    page.nil? ? 0 : (@limit * (page.to_i - 1))
  end
end
