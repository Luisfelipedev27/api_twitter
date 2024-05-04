class Post < ApplicationRecord
  belongs_to :user
  belongs_to :repost, class_name: 'Post', optional: true, foreign_key: 'repost_id'
  belongs_to :quote, class_name: 'Post', optional: true, foreign_key: 'quote_id'

  validates :content, presence: true, length: { maximum: 777 }
  validates :quote_content, length: { maximum: 777 }
  validate :daily_post_limit, on: :create

  private

  def daily_post_limit
    if Post.where(user_id: user_id, created_at: Date.today.beginning_of_day..Date.today.end_of_day).count >= 5

      errors.add(:base, 'Exceeded daily post limit')
    end
  end
end
