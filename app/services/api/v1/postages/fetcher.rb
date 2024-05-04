module Api
  module V1
    module Postages
      class Fetcher
        attr_reader :post, :error_message

        def initialize(params)
          self.params = params
          self.start_date = params[:start_date].to_datetime if params[:start_date].present?
          self.end_date = params[:end_date].to_datetime.end_of_day if params[:end_date].present?
        end

        def self.call(*args)
          new(*args).call
        end

        def call
          fetch_post

          self
        end

        def success?
          error_message.blank?
        end

        private

        attr_writer :post, :error_message

        attr_accessor :params, :start_date, :end_date

        def fetch_post
          posts = if params[:user_id].present?
            Post.where(user_id: params[:user_id])
          else
            Post.all
          end

          if start_date.present? || end_date.present?
            posts = posts.where(created_at: start_date..(end_date || DateTime.now.to_s))
          end

          self.post = posts.order(created_at: :desc).offset(params[:offset]).limit(10).map do |p|
            {
              id: p.id,
              author: p.user.username,
              content: p.content
            }.tap do |hash|
              hash[:quote_content] = p.quote_content if p.repost_id.present? && p.quote_content.present?
            end
          end

          true
        rescue ActiveRecord::RecordNotFound
          self.error_message = 'post not found'

          false
        end
      end
    end
  end
end
