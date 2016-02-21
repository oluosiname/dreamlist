class Api::V1::ItemsController < ApplicationController
  include BucketlistHelper
  include ItemHelper

  def create
    if user_bucket(params[:bucketlist_id])
      save_item(item_params, params[:bucketlist_id])
    else
      render json: { message: "Bucketlist does not exist" }
    end
  end

  def update
    if user_bucket(params[:bucketlist_id])
      update_item(item_params, params[:bucketlist_id], params[:id])
    else
      render json: { message: " Bucketlistdoes not exist" }
    end
  end

  def destroy
    if user_bucket(params[:bucketlist_id])
      delete_item(params[:bucketlist_id], params[:id])
    else
      render json: { message: "Bucketlist does not exist" }, status: 404
    end
  end

  def item_params
    params.permit(:name, :done)
  end
end
