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

  def update_item(item_params, bucketlist_id, id)
    item = Item.find_by_id(id)

    if item && belong_to_bucket?(bucketlist_id, item)
      item.update item_params
      render json: item, status: 200
    else
      render json: { error: "Item does not exist in this bucketlist" }
    end
  end

  def delete_item(bucketlist_id, id)
    item = Item.find_by(id: id)

    if item && belong_to_bucket?(bucketlist_id, item)
      item.destroy
      render json: { notice: "Item deleted" }, status: 200
    else
      render json: { error: "Item does not exist in this bucketlist" }
    end
  end

  def belong_to_bucket?(bucketlist_id, item)
    item.bucketlist_id == bucketlist_id
  end
end
