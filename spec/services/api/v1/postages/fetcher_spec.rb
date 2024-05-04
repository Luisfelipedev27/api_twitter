require 'rails_helper'

RSpec.describe Api::V1::Postages::Fetcher do
  context 'when fetches posts from homepage' do
    it 'return the last 10 posts by user' do
      user = User.create!(id: 1, username: 'luis')
      second_user = User.create!(id: 2, username: 'joseph')
      params = { user_id: user.id}

      15.times do |i|
        Timecop.freeze(Date.today - i.days) do
          Post.create!(user: user, content: "Post content #{i}")
          Post.create!(user: second_user, content: "Post content #{i}")
        end
      end

      posts = Post.where(user_id: user.id).order(created_at: :desc).take(10)

      service = described_class.call(params)

      expect(service).to be_success
      expect(service.post).to eq(posts.map { |post| { author: post.user.username, content: post.content, id: post.id } })
    end

    it 'return the last 10 posts by all users' do
      user = User.create!(id: 1, username: 'luis')
      second_user = User.create!(id: 2, username: 'joseph')

      15.times do |i|
        Timecop.freeze(Date.today - i.days) do
          Post.create!(user: user, content: "Post content #{i}")
          Post.create!(user: second_user, content: "Post content #{i}")
        end
      end

      posts = Post.order(created_at: :desc).take(10)

      service = described_class.call(offset: 0)

      expect(service).to be_success
      expect(service.post).to eq(posts.map { |post| { author: post.user.username, content: post.content, id: post.id } })
    end

    it 'return the last 10 posts by user with offset' do
      user = User.create!(id: 1, username: 'luis')
      second_user = User.create!(id: 2, username: 'joseph')

      15.times do |i|
        Timecop.freeze(Date.today - i.days) do
          Post.create!(user: user, content: "Post content #{i}")
          Post.create!(user: second_user, content: "Post content #{i}")
        end
      end

      params = {
        user_id: user.id,
        offset: 10
      }

      posts = Post.where(user_id: user.id).order(created_at: :desc).offset(10).take(10)

      service = described_class.call(params)

      expect(service).to be_success
      expect(service.post).to eq(posts.map { |post| { author: post.user.username, content: post.content, id: post.id } })
    end

    it 'return all posts with start and end date' do
      user = User.create!(id: 1, username: 'luis')
      second_user = User.create!(id: 2, username: 'joseph')

      15.times do |i|
        Timecop.freeze(Date.today - i.days) do
          Post.create!(user: user, content: "Post content #{i}")
          Post.create!(user: second_user, content: "Post content #{i}")
        end
      end

      params = {
        start_date: (Date.today - 5.days).to_s,
        end_date: (Date.today).to_s
      }

      posts = Post.where(created_at: ((DateTime.now.to_s.to_datetime - 5.days).to_s)..DateTime.now.to_s).order(created_at: :desc)

      service = described_class.call(params)

      expect(service).to be_success
      expect(service.post).to eq(posts.map { |post| { author: post.user.username, content: post.content, id: post.id } })
    end
  end

  context 'when fetches posts from user profile page' do
    it 'is success' do
      user = User.create!(id: 1, username: 'luis')
      post = Post.create!(user: user, content: 'Post content')

      params = {
        offset: 0,
        id: user.id
      }

      service = described_class.call(params)

      expect(service).to be_success
      expect(service.post).to eq([{ author: post.user.username, content: post.content, id: post.id }])
    end
  end
end
