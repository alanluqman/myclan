require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before(:example) do
    @subject1 = User.create(name: 'Alan Luqman', photo: 'user picture', bio: 'Teacher from UK.')
    @subject2 = User.create(name: 'Nich', photo: 'user picture', bio: 'Teacher from Negiria.')

    visit '/'
  end

  describe 'user index page' do
    it ' -> I can see the username of all other users.' do
      expect(page).to have_content(@subject1.name)
      expect(page).to have_content(@subject2.name)
    end

    it ' -> I can see the profile picture for each user.' do
      visit user_path(id: @subject1.id)
      find("img[src='user picture']")
    end

    it ' -> I can see the number of posts each user has written.' do
      expect(page).to have_content(@subject1.post_counter)
      expect(page).to have_content(@subject2.post_counter)
    end

    it ' -> When I click on a user, I am redirected to that user show page.' do
      click_link(@subject1.name)
      expect(current_path).to match user_path(@subject1)
    end
  end
end
