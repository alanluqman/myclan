require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
  before(:example) do
    @subject1 = User.create(name: 'Alan Luqman', photo: 'user picture', bio: 'Teacher from UK.')
    @subject2 = User.create(name: 'Alex', photo: 'picture', bio: 'Teacher from UK.')
    @post = Post.create(author: @subject1, title: 'Hello', text: 'This is my first post')
    Comment.create(author_id: @subject2.id, post_id: @post.id, text: 'this is first comment')

    visit user_posts_path(user_id: @subject1.id)
  end

  describe 'Post index page' do
    it 'I can see the user profile picture.' do
      find("img[src='user picture']")
    end

    it 'I can see the user username.' do
      expect(page).to have_content(@subject1.name)
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content(@subject1.post_counter)
    end

    it 'I can see a post title.' do
      expect(page).to have_content(@post.title)
    end

    it 'I can see some of the post body.' do
      expect(page).to have_content(@post.text)
    end

    it 'I can see the first comments on a post.' do
      expect(page).to have_content('this is first comment')
    end

    it 'I can see how many comments a post has.' do
      expect(page).to have_content(@post.comment_counter)
    end

    it 'I can see how many likes a post has.' do
      expect(page).to have_content(@post.like_counter)
    end

    it 'When I click on a post, it redirects me to that post show page.' do
      click_link(@post.title.to_s)
      expect(current_path).to eq "/users/#{@subject1.id}/posts/#{@post.id}"
    end
  end
end
