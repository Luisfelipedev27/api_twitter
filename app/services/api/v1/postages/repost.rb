module Api
  module V1
    module Postages
      class Repost
        attr_reader :repost, :error_message

        def initialize(params)
          self.params = params
          self.original_post = original_post
        end

        def self.call(*args)
          new(*args).call
        end

        def call
          fetch_post && create_repost

          self
        end

        def success?
          error_message.blank?
        end

        private

        attr_writer :repost, :error_message

        attr_accessor :params, :original_post

        def fetch_post
          self.original_post = Post.find(params[:id])

          true
        rescue ActiveRecord::RecordNotFound
          self.error_message = 'post not found'

          false
        end

        def create_repost
          self.repost = Post.create(
            content: original_post.content,
            user_id: params[:user_id],
            original_post_id: original_post.id,
            quote_content: params[:quote_content]
            )

          repost.update!(repost_id: repost.id, quote_id: repost.id )

          true
        rescue ActiveRecord::RecordInvalid
          self.error_message = 'invalid repost'

          false
        end
      end
    end
  end
end
