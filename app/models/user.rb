class User < ApplicationRecord
  has_mnay :posts, class_name: 'Post'
  has_many :comments, class_name: 'Comment'
  has_many :likes, class_name: 'Like'
end
