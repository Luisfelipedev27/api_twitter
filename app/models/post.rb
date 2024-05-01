class Post < ApplicationRecord
  belongs_to :user
  belongs_to :repost, class_name: 'Post', optional: true
  belongs_to :quote, class_name: 'Post', optional: true

  validates :content, length: { maximum: 777 }
end
