class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  #validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_presence_of :comment, :on => :create, :message => "can't be blank"
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  def author
    self.user.username
  end
  
  def as_json(options)
    hash = super(options)
    hash['comment']['author'] = self.author
    return hash
  end
end
