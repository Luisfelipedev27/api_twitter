require 'rails_helper'

RSpec.describe Api::V1::Users::Fetcher do
  context 'when fetches user and posts' do
    it 'return user and posts' do
      user = User.create!(id: 1, username: 'luis')
      second_user = User.create!(id: 2, username: 'joseph')
      params = { id: user.id, offset: 0 }

      15.times do |i|
        Timecop.freeze(Date.today - i.days) do
          Post.create!(user: user, content: "Post content #{i}")
          Post.create!(user: second_user, content: "Post content #{i}")
        end
      end

      posts = Post.where(user_id: user.id).order(created_at: :desc).offset(0).take(5)

      service = described_class.call(params)

      expect(service).to be_success
      expect(service.user).to eq(user)
      expect(service.post).to eq(posts.map { |post| { id: post.id, content: post.content } })
    end

    it 'return user and posts with offset' do
      user = User.create!(id: 1, username: 'luis')
      second_user = User.create!(id: 2, username: 'joseph')
      params = { id: user.id, offset: 10 }

      15.times do |i|
        Timecop.freeze(Date.today - i.days) do
          Post.create!(user: user, content: "Post content #{i}")
          Post.create!(user: second_user, content: "Post content #{i}")
        end
      end

      posts = Post.where(user_id: user.id).order(created_at: :desc).offset(10).take(5)

      service = described_class.call(params)

      expect(service).to be_success
      expect(service.user).to eq(user)
      expect(service.post).to eq(posts.map { |post| { id: post.id, content: post.content } })
    end

    it 'does not fetch user your posts' do
      params = { id: 1, offset: 0 }

      service = described_class.call(params)

      expect(service).not_to be_success
      expect(service.error_message).to be_present
    end
  end
end
