module Api
  module V1
    class PostsController < ApplicationController
      def index
        service = Api::V1::Postages::Fetcher.call(permitted_params)

        if service.success?
          render json: service.post, status: :ok
        else
          render json: { error: service.error_message }, status: :not_found
        end
      end

      def create
        service = Api::V1::Postages::Creator.call(permitted_params)

        if service.success?
          render json: service.post, status: :created
        else
          render json: { error: service.error_message }, status: :unprocessable_entity
        end
      end

      def repost
        service = Api::V1::Postages::Repost.call(permitted_params)

        if service.success?
          render json: service.repost, status: :created
        else
          render json: { error: service.error_message }, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params.permit(:offset, :start_date, :end_date, :content, :user_id, :id, :quote_content)
      end
    end
  end
end
