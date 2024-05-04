module Api
  module V1
    module Postages
      class Creator
        attr_reader :post, :error_message

        def initialize(params)
          self.params = params
        end

        def self.call(*args)
          new(*args).call
        end

        def call
          create_post

          self
        end

        def success?
          error_message.blank?
        end

        private

        attr_writer :post, :error_message

        attr_accessor :params

        def create_post
          self.post = Post.create!(content: params[:content], user_id: params[:user_id] || params[:id] )

          true
        rescue ActiveRecord::RecordInvalid
          self.error_message = 'invalid post'

          false
        end
      end
    end
  end
end
