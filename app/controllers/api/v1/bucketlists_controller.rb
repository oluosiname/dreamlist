class Api::V1::BucketlistsController < ApplicationController
  def create
    bucketlist = Bucketlist.new(bucket_params)
    bucketlist.user_id = current_user.id
    if bucketlist.save
      render json: bucketlist
    else
      render json: bucketlist.errors, status: 422
    end
  end

  def show
    bucketlist = current_user.bucketlists.find_by_id(params[:id])
    render json: bucketlist
  end

  def bucket_params
    params.permit(:name)
  end
end
