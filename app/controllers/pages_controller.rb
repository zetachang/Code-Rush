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
    @comment.anchor = "main" if @comment.anchor.blank?
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        @page.comments << @comment
        format.html { redirect_to @page, :notice => 'Comments added' }
        format.js
      else
        format.js {render :json => 'alert("fucked");'}
      end
    end
  end
  
  def destroy_comment
    
  end
end
