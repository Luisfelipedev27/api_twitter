require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:valid_attributes) { { username: 'luis' } }
  let(:invalid_attributes) { { username: nil } }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'renders a JSON response with the new user' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the new user' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'GET #show' do
    let(:user) { User.create!(id: 1, username: 'luis') }
    let(:post) { Post.create!(user: user, content: 'Post content') }

    it 'returns a success response' do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create_post' do
    let(:user) { User.create!(id: 1, username: 'luis') }
    let(:valid_post_attributes) { { id: user.id, content: 'Post content' } }
    let(:invalid_post_attributes) { { id: 1, user_id: nil, content: nil } }

    context 'with valid parameters' do
      it 'renders a JSON response with the new post' do
        post :create_post, params: valid_post_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the new post' do
        post :create_post, params: invalid_post_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
