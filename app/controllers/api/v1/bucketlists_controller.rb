class Api::V1::BucketlistsController < ApplicationController
  include BucketlistHelper
  def index
    bucketlists = Bucketlist.by_user(current_user)
    render json: bucketlists, status: 200
  end

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
    if user_bucket(params[:id])
      bucketlist = user_bucket(params[:id])
      render json: bucketlist
    else
      render json: { error: "No such Bucketlist found" }, status: 404
    end
  end

  def destroy
    if user_bucket(params[:id])
      user_bucket(params[:id]).destroy
      render json: { notice: "Bucketlist deleted" }, status: 200
    else
      render json: { error: "No such Bucketlist found" }, status: 404
    end
  end

  def bucket_params
    params.permit(:name)
  end
end
