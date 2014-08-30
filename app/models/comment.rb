class Comment < ActiveRecord::Base
  validates :content, :author, :post, presence: true
  
  belongs_to :author,
  class_name: 'User',
  foreign_key: :author_id,
  primary_key: :id
  
  belongs_to :post
  
  belongs_to :parent_comment,
  class_name: 'Comment',
  foreign_key: :parent_comment_id,
  primary_key: :id
  
  has_many :child_comments,
  class_name: 'Comment',
  foreign_key: :parent_comment_id,
  primary_key: :id
  
  has_many :votes, as: :votable
  
  def score
    score = 0
    self.votes.each do |vote|
      score += vote.value
    end
    score
  end
end