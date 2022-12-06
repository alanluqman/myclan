require 'rails_helper'

RSpec.describe 'Users', type: :request do
  subject { User.create(name: 'Alan Luqman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from UK.') }

  describe 'GET /users#index' do
    before(:example) do
      get '/'
    end

    it 'responds success' do
      expect(response).to have_http_status(200)
    end

    it 'rendering index success' do
      expect(response).to render_template(:index)
    end

    it 'render index correctly' do
      expect(response.body).to include('All users listed here')
    end
  end

  describe 'GET /users#show' do
    before(:example) do
      get "/users/#{subject.id}"
    end

    it 'responds success' do
      expect(response).to have_http_status(200)
    end

    it 'render show user' do
      expect(response).to render_template(:show)
    end

    it 'render user with spesific id' do
      expect(response.body).to include("A details of specific user #{subject.id} shown here")
    end
  end
end
