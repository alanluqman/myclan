class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, class_name: 'Comment'
  has_many :likes, class_name: 'Like'

  after_save :update_post_counter

  def update_post_counter
    author.increment!(:post_counter)
  end

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
