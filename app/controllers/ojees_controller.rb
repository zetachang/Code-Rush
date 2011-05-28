class OjeesController < ApplicationController
  # GET /ojees
  # GET /ojees.xml
  def index
    @ojees = Oier.find(params[:oier_id]).ojees
    @oier = Oier.find(params[:oier_id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ojees }
    end
  end

  # GET /ojees/new
  # GET /ojees/new.xml
  def new
    @ojee = Ojee.new
    @oier = Oier.find(params[:oier_id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ojee }
    end
  end

  # GET /ojees/1/edit
  def edit
    @oier = Oier.find(params[:oier_id])
    @ojee = @oier.ojees.find(params[:id]) 
  end

  # POST /ojees
  # POST /ojees.xml
  def create
    @ojee = Ojee.new(params[:ojee])
    @ojee.oier = Oier.find(params[:oier_id])
    
    respond_to do |format|
      if @ojee.save
        format.html { redirect_to(oier_ojees_path(params[:oier_id]), :notice => 'OJ Account was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /ojees/1
  # PUT /ojees/1.xml
  def update
    @ojee = Ojee.find(params[:id])

    respond_to do |format|
      if @ojee.update_attributes(params[:ojee])
        format.html { redirect_to(oier_ojees_path(params[:oier_id]), :notice => 'OJ Account was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /ojees/1
  # DELETE /ojees/1.xml
  def destroy
    @ojee = Ojee.find(params[:id])
    @ojee.destroy

    respond_to do |format|
      format.html { redirect_to(oier_ojees_path(params[:oier_id]), :notice => 'Oj Account was successfully deleted') }
      format.xml  { head :ok }
    end
  end
end
