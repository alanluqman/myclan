require 'rails_helper'

RSpec.describe Post, type: :model do

    subject do
      user = User.new(name: 'alan', photo: 'http://picture', bio: 'I am developer')
      Post.new(title: 'new post', text: 'this is first post', author: user)
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'user post_counter should be 1' do
      expect(subject.title).to eq('new post')
    end

    it 'blank title raises error' do
      subject.title = ''
      expect { subject.save! }.to raise_error(ActiveModel::StrictValidationFailed)
    end

    it 'title is too long' do
      subject.title = 'a' * 255
      expect(subject).to_not be_valid
    end

    it 'comment_counter is an integer' do
      user = User.create(name: 'alan', photo: 'http://picture', bio: 'I am developer')
      Comment.create(post: subject, author: user, text: 'Hi Alan!')
      expect(subject.comment_counter).to eq(1)
    end
    
    it 'comment_counter is an integer' do
      user = User.create(name: 'alan', photo: 'http://picture', bio: 'I am developer')
      Post.create(title: 'new post', text: 'this is first post', author: user)
      expect(user.post_counter).to eq(1)
    end
end