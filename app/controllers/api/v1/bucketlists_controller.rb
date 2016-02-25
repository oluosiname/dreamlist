module Api
  module V1
    class BucketlistsController < ApplicationController
      include BucketlistHelper
      def index
        bucketlists = user_buckets.search(
          params[:q]
        ).by_page(
          set_limit(params[:limit]),
          set_offset(params[:page])
        )
        render json: bucketlists, status: 200
      end

      def create
        bucketlist = Bucketlist.new(bucket_params)
        bucketlist.user_id = current_user.id

        if bucketlist.save
          render json: bucketlist, status: 200
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

      def update
        bucketlist = user_bucket(params[:id])

        if bucketlist.update(bucket_params)
          render json: bucketlist, status: 201
        else
          render json: bucketlist.errors, status: 400
        end

      rescue
        render json: { error: "No such Bucketlist found" }, status: 404
      end

      def bucket_params
        params.permit(:name)
      end
    end
  end
end
