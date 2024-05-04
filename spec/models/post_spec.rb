require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:repost).class_name('Post').optional }
    it { is_expected.to belong_to(:quote).class_name('Post').optional }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:content).is_at_most(777) }
    it { is_expected.to validate_length_of(:quote_content).is_at_most(777) }
  end

  describe 'custom validations' do
    let(:user) { User.create!(id: 1, username: 'luis') }

    it 'should validate the daily post limit' do
      5.times do
        Post.create!(user: user, content: 'Post content')
      end

      post = Post.new(user: user, content: 'Post content')
      post.valid?

      expect(post.errors[:base]).to include('Exceeded daily post limit')
    end
  end
end
