require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before(:example) do
    @subject1 = User.create(name: 'Alan Luqman',
                            photo: 'user picture', bio: 'Teacher from UK.')
    @post = Post.create(author: @subject1, title: 'demo', text: 'rails testing project')

    Post.create(author: @subject1, title: 'nick', text: 'nick start new role as web developer')
    Post.create(author: @subject1, title: 'rex', text: 'rex start new role as web developer')
    Post.create(author: @subject1, title: 'ogaga', text: 'ogaga start new role as web developer')

    visit user_path(id: @subject1.id)
  end

  describe 'index page' do
    it '-> I can see the users profile picture.' do
      find("img[src='#{@subject1.photo}']")
    end

    it '-> I can see the users username.' do
      expect(page).to have_content(@subject1.name)
    end

    it '-> I can see the number of posts the user has written.' do
      expect(page).to have_content(@subject1.post_counter)
    end

    it '-> I can see the user bio.' do
      expect(page).to have_content(@subject1.bio)
    end

    it '-> I can see the users first 3 posts.' do
      expect(page).to have_content('ogaga')
      expect(page).to have_content('rex')
      expect(page).to have_content('nick')
    end

    it '-> I can see a button that lets me view all of a users posts.' do
      expect(page).to have_link('All Posts') if @subject1.post_counter > 0
    end

    it '-> When I click a users post, it redirects me to that posts show page.' do
      visit user_posts_path(user_id: @subject1.id)
      click_link(@post.title)

      expect(current_path).to eq user_post_path(user_id: @subject1.id, id: @post.id)
    end

    it '-> When I click to see all posts, it redirects me to the users posts index page.' do
      if @subject1.post_counter > 0
        click_link('All Posts')
        expect(current_path).to eq "/users/#{@subject1.id}/posts"
      else
        expect(page).to have_content('The list is empty for the posts by the user')
      end
    end
  end
end
