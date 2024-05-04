require 'rails_helper'

RSpec.describe Api::V1::Postages::Repost do
  context 'when does not find a post' do
    it 'does not repost a post' do
      params = { id: 1, user_id: 1 }

      service = described_class.call(params)

      expect(service).not_to be_success
      expect(service.error_message).to eq('post not found')
    end
  end

  context 'when find a post' do
    it 'repost a post' do
      user = User.create!(id: 1, username: 'luis')
      original_post = Post.create!(user: user, content: 'Original post content')

      params = {
        id: original_post.id,
        user_id: user.id,
        quote_content: 'Quote content'
      }

      service = described_class.call(params)

      expect(service).to be_success
      expect(service.repost).to have_attributes(
        content: original_post.content,
        user_id: user.id,
        repost_id: service.repost.id,
        quote_id: service.repost.id,
        original_post_id: original_post.id,
        quote_content: params[:quote_content]
      )
    end

    it 'does not repost a post' do
      user = User.create!(id: 1, username: 'luis')
      original_post = Post.create!(user: user, content: 'Original post content')

      params = {
        id: original_post.id,
        user_id: nil
      }

      service = described_class.call(params)

      expect(service).not_to be_success
      expect(service.error_message).to eq('invalid repost')
    end
  end
end
