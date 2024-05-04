require 'rails_helper'

RSpec.describe Api::V1::Postages::Creator do
  context 'when creates a post from homepage' do
    it 'is success' do
      user = User.create!(id: 1, username: 'luis')

      params = {
        content: 'Post content',
        user_id: user.id
      }

      service = described_class.call(params)

      expect(service).to be_success
      expect(service.post).to have_attributes(
        content: params[:content],
        user_id: params[:user_id]
      )
    end
  end

  context 'when creates a post from user profile page' do
    it 'is success' do
      user = User.create!(id: 1, username: 'luis')

      params = {
        content: 'Post content',
        id: user.id
      }

      service = described_class.call(params)

      expect(service).to be_success
      expect(service.post).to have_attributes(
        content: params[:content],
        user_id: params[:id]
      )
    end
  end

  context 'when creates a post' do
    it 'is not a success' do
      user = User.create!(id: 1, username: 'luis')

      params = {
        content: nil,
        user_id: user.id
      }

      service = described_class.call(params)

      expect(service).not_to be_success
      expect(service.error_message).to eq('invalid post')
    end
  end
end
