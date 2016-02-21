module ItemHelper
  # extend ActiveSupport::Concerns
  def save_item(item_params, bucketlist_id)
    item = Item.new(item_params)
    if item.save
      item.update_attributes bucketlist_id: bucketlist_id
      render json: item, status: 200
    else
      render json: item.errors
    end
  end

  def belong_to_bucket?(bucketlist_id, item)
    item.bucketlist_id == bucketlist_id
  end
end
