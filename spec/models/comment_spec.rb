require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject do
    user = User.create(name: 'alan', photo: 'http://picture', bio: 'I am developer')
    post = Post.create(title: 'new post', text: 'this is first post', author: user)
    Comment.create(post:, author: user, text: 'Hi Alan!')
  end

  it '# is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'comment_counter get incremented by 1' do
    expect(subject.post.comment_counter).to eq(1)
  end
end
