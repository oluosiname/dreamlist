class Api::V1::BucketlistsController < ApplicationController
  def index
    bucketlists = Bucketlist.by_user(current_user)
    render json: bucketlists, status: 200
  end

  def create
    bucketlist = Bucketlist.new(bucket_params)
    bucketlist.user_id = current_user
    if bucketlist.save
      render json: bucketlist
    else
      render json: bucketlist.errors
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
