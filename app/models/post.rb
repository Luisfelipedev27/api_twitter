class Post < ApplicationRecord
  belongs_to :user
  belongs_to :repost, class_name: 'Post', optional: true, foreign_key: 'repost_id'
  belongs_to :quote, class_name: 'Post', optional: true, foreign_key: 'quote_id'

  validates :content, length: { maximum: 777 }
end
