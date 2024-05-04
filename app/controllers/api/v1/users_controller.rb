module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(permitted_params)
        if user.save
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def show
        service = Api::V1::Users::Fetcher.call(permitted_params)

        if service.success?
          render json: {
            username: service.user.username,
            joined: service.user.created_at.strftime("%B %d, %Y"),
            posts_count: service.user.posts.count,
            posts: service.post
          },
          status: :ok
        else
          render json: { error: service.error_message }, status: :not_found
        end
      end

      def create_post
        service = Api::V1::Postages::Creator.call(permitted_params)

        if service.success?
          render json: service.post, status: :created
        else
          render json: { error: service.error_message }, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params.permit(:username, :id, :offset, :content)
      end
    end
  end
end
