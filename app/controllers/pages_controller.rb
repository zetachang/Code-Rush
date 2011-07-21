class PagesController < ApplicationController
  authorize_resource :only => [:create_comment]
  def index
    @pages = Page.all
  end

  def show
    @page = Page.find_by_munged_title(params[:id])
  end

  def new
  end

  def create
  end

  def edit
    @page = Page.find_by_munged_title(params[:id])
  end

  def update
    @page = Page.find_by_munged_title(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to @page, :notice => 'This page is successfully updated!'
    else
      render "edit"
    end
  end

  def destroy
  end
  
  def create_comment
    @page = Page.find_by_munged_title(params[:id])
    @comment = Comment.new(params[:comment])
    if @comment.anchor.blank?
      @comment.anchor = "main"
    end
    @comment.user = current_user
    if @comment.save
      @page.comments << @comment
      if request.xhr?
        render :json => @comment 
      else  
        redirect_to @page, :notice => 'Comments added'
      end
    else
      if request.xhr?
        render :text => "Comment field can't be blank!" 
      else
        redirect_to @page, :alert => 'Failed to add comment'
      end
    end
  end
  
  def destroy_comment
    
  end
end
