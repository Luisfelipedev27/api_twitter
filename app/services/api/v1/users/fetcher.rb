module Api
  module V1
    module Users
      class Fetcher
        attr_reader :user, :post, :error_message

        def initialize(params)
          self.params = params
        end

        def self.call(*args)
          new(*args).call
        end

        def call
          fetch_user && fetch_post

          self
        end

        def success?
          error_message.blank?
        end

        private

        attr_writer :user, :post, :error_message

        attr_accessor :params

        def fetch_user
          self.user = User.find(params[:id])

          true
        rescue ActiveRecord::RecordNotFound
          self.error_message = 'user not found'

          false
        end

        def fetch_post
          self.post = user.posts.order(created_at: :desc).offset(params[:offset]).limit(5).map do |u|
            {
              id: u.id,
              content: u.content
            }
          end

          true
        rescue ActiveRecord::RecordNotFound
          self.error_message = 'No posts to display'

          false
        end
      end
    end
  end
end
