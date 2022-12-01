require 'rails_helper'

RSpec.describe Like, type: :model do

  subject do
    user = User.create(name: 'alan', photo: 'http://picture', bio: 'I am developer')
    post = Post.create(title: 'new post', text: 'this is first post', author: user)
    Like.create(post: post, author: user)
  end

  it '# is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'like_counter get incremented by 1' do
    expect(subject.post.like_counter).to eq(1)
  end

end