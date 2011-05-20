class PostsController < ApplicationController
  def index
    @post = Post.find 
      :all,
      :conditions => ['created_at >?', 3.months.ago],
      :limit      => 5,
      :include    => :comments
  end
end