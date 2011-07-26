class CodesController < ApplicationController
  load_resource :except => [:tags, :all_tags]
  authorize_resource 
  # GET /codes
  # GET /codes.xml
  def index
  end

  # GET /codes/1
  # GET /codes/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @code }
    end
  end

  # GET /codes/new
  # GET /codes/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @code }
    end
  end

  # GET /codes/1/edit
  def edit
  end

  # POST /codes
  # POST /codes.xml
  def create
    @code.creator = current_oier.name
    respond_to do |format|
      if @code.save
        format.html { redirect_to(@code, :notice => 'Code was successfully created.') }
        format.xml  { render :xml => @code, :status => :created, :location => @code }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /codes/1
  # PUT /codes/1.xml
  def update
    respond_to do |format|
      if @code.update_attributes(params[:code])
        format.html { redirect_to(@code, :notice => 'Code was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /codes/1
  # DELETE /codes/1.xml
  def destroy
    @code.destroy
    respond_to do |format|
      format.html { redirect_to(codes_url) }
      format.xml  { head :ok }
    end
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
