class Page < ActiveRecord::Base
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :title, :on => :create, :message => "must be unique"
  serialize :author
  acts_as_commentable
  
  def main_comments
    self.comments.select{|c| c.anchor == 'main'}
  end
  def to_param
    self.title.parameterize
  end
  
  def self.find_by_munged_title(title)
    find_each do |page|
      return page if page.title.parameterize == title
    end
    nil
  end
end
