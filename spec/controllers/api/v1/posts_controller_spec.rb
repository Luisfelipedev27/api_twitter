require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:user) { User.create!(id: 1, username: 'luis') }
  let(:valid_attributes) { { user_id: user.id, content: 'Post content' } }
  let(:invalid_attributes) { { user_id: nil, content: nil } }

  describe 'GET #index' do
    it 'returns a success response' do
      post = Post.create! valid_attributes
      get :index, params: { user_id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'renders a JSON response with the new post' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the new post' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'POST #repost' do
    context 'with valid parameters' do
      let(:original_post) { Post.create!(user: user, content: 'Original post content') }
      let(:valid_repost_params) { { id: original_post.id, user_id: user.id, post_id: original_post.id } }

      it 'renders a JSON response with the new repost' do
        post :repost, params: valid_repost_params
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the new repost' do
        post :repost, params: { id: 1, user_id: nil, post_id: nil }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
