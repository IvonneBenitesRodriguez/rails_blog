require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) do
    User.create(
      name: 'Ivonne Benites',
      photo: 'https://example.com/ivonnebenites.jpg',
      bio: 'Software Engineer',
      posts_counter: 0
    )
  end

  let(:sample_post) do
    Post.create(
      title: 'Sample Post',
      comments_counter: 0,
      likes_counter: 0,
      author: user
    )
  end

  describe 'GET /users/:user_id/posts' do
    before { get user_posts_path(user) }

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    before { get user_post_path(user, sample_post) }

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end
end
