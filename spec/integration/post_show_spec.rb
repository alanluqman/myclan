require 'rails_helper'

RSpec.describe 'renders post index Page', type: :feature do
  before(:example) do
    @subject1 = User.create(name: 'Alan Luqman', photo: 'user picture', bio: 'Teacher from UK.')
    @subject2 = User.create(name: 'Alex', photo: 'picture', bio: 'Teacher from USA.')
    @post = Post.create(author: @subject1, title: 'Hello', text: 'This is my first post')
    Comment.create(text: 'this is my first comment', author_id: @subject2.id, post_id: @post.id)

    visit user_post_path(user_id: @subject1.id, id: @post.id)
  end

  it 'I can see the post title.' do
    expect(page).to have_content(@post.title)
  end

  it 'I can see who wrote the post.' do
    expect(page).to have_content(@subject1.name)
  end

  it 'I can see how many comments it has.' do
    expect(page).to have_content(@post.comment_counter)
  end

  it 'I can see how many likes it has.' do
    expect(page).to have_content(@post.like_counter)
  end

  it 'I can see the post body.' do
    expect(page).to have_content(@post.text)
  end

  it 'I can see the username of each commentor.' do
    expect(page).to have_content(@subject2.name)
  end

  it 'I can see the comment each commentor left.' do
    expect(page).to have_content('this is my first comment')
  end
end
