require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  subject { User.create(name: 'Alan Luqman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from UK.') }

  describe 'GET /posts#index' do
    before(:example) do
      get "/users/#{subject.id}/posts"
    end

    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders post index success' do
      expect(response).to render_template(:index)
    end

    it 'render index should include ' do
      expect(response.body).to include("All posts by given user #{subject.id} listed here")
    end
  end

  describe 'GET /posts#show' do
    before(:example) do
      post = Post.create(author: subject, title: 'Hello', text: 'This is my first post')
      get "/users/#{subject.id}/posts/#{post.id}"
    end

    it '-> returns http success' do
      expect(response).to have_http_status(200)
    end

    it '-> renders post show success' do
      expect(response).to render_template(:show)
    end

    it '-> render show should include ' do
      expect(response.body).to include('User Post detail')
    end
  end
end
