class CodesController < ApplicationController
  load_resource :except => [:tags, :all_tags]
  authorize_resource 
  
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @code.oier = current_oier
    if @code.save
      redirect_to @code, :notice => 'Code was successfully created.'
    else
      render :action => "new" 
    end
  end

  def update
    if @code.update_attributes(params[:code])
      redirect_to @code, :notice => 'Code was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @code.destroy
    redirect_to(codes_url)
  end
  
  def tags
    @codes = Code.tagged_with(params[:id])
    render :action => :index
  end
  
  def all_tags
    tags = Code.tag_counts_on(:tags).select{|t| t.name. =~ Regexp.new("^" + params[:key].strip,true)}.collect{|t| t.name}
    render :json => tags
  end

  def my_codes
    @codes = Code.where(:creator => current_oier.name)
    render :action => 'index'
  end
end
