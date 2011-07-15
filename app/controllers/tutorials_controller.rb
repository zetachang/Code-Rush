class TutorialsController < ApplicationController
  load_resource
  def show
  end
  
  def new_comment
    @tutorial = Tutorial.find(params[:id])
    @comment = Comment.new
    respond_to do |format|
      format.html do
        if request.xhr?
          render :partial => "tutorials/new_comment", :layout => false
        else
          render :partial => "tutorials/new_comment"
        end
      end
    end
  end
  
  def create_comment
    @comment = Comment.new(params[:comment])
    if @comment.save
      @tutorial.comments << @comment
      render :partial => 'tutorial/show_comment', :locals => {:comment => @comment },:layout => false
    else
      render :json => @comment.errors, :status => :unprocessable_entity
    end
  end
  
  def delete_comment
    @comment = Comment.find(params[:comment])
    if @comment.destroy
      render :text => 'Deleted'
    else
      render :text => 'fuck'
    end
  end

end
