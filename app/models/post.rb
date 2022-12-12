class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, class_name: 'Comment', foreign_key: 'post_id'
  has_many :likes, class_name: 'Like', foreign_key: 'post_id'

  validates :title, presence: { strict: true }, length: { minimum: 3, maximum: 250 }
  validates :comment_counter, :like_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_post_counter

  def update_post_counter
    author.increment!(:post_counter)
  end

  def five_recent_comments
    comments.includes([:author]).order(created_at: :desc).limit(5)
  end
end
