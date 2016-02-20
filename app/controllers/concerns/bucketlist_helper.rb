module BucketlistHelper
  def user_bucket(id)
    current_user.bucketlists.find_by_id(id)
  end

  def user_buckets
    current_user.bucketlists
  end

  def set_limit(limit)
    @limit = limit
    @limit ||= 20
    @limit = 100 if limit.to_i > 100
    @limit.to_i
  end

  def set_page(page)
    page ||= 1
    @page = page
    @page.to_i
  end

  def set_offset
    offset = @limit.to_i * (@page.to_i - 1)
  end
end
