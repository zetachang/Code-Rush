class OiersController < ApplicationController
  before_filter :authenticate_user! ,:except => [:index,:show]
  # GET /oiers
  def index
    @oiers = Oier.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oiers }
    end
  end

  # GET /oiers/1
  def show
    @oier = Oier.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @oier }
    end
  end

  # GET /oiers/new
  def new
    @oier = Oier.new
  end

  # GET /oiers/1/edit
  def edit
    @oier = Oier.find(params[:id])
  end

  # POST /oiers
  # POST /oiers.xml
  def create
    @oier = Oier.new(params[:oier])
    @oier.user = current_user
    
    respond_to do |format|
      if @oier.save
        format.html { redirect_to(@oier, :notice => 'Oier was successfully created.') }
        format.xml  { render :xml => @oier, :status => :created, :location => @oier }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @oier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /oiers/1
  # PUT /oiers/1.xml
  def update
    @oier = Oier.find(params[:id])

    respond_to do |format|
      if @oier.update_attributes(params[:oier])
        format.html { redirect_to(@oier, :notice => 'Oier was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @oier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /oiers/1
  # DELETE /oiers/1.xml
  def destroy
    @oier = Oier.find(params[:id])
    @oier.destroy

    respond_to do |format|
      format.html { redirect_to(oiers_url) }
      format.xml  { head :ok }
    end
  end
  
  def update_all
    Ojee.find_each do |ojee|
      ojee.problem_solved
    end
  end
end
