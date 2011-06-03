class TiojOjeesController < ApplicationController
  def new
  
  end

  def edit
    @oier = Oier.find(params[:oier_id])
    @tioj_ojee = @oier.ojees.find(params[:id])
  end

  def create
    
  end

  def update
    @tioj_ojee = TiojOjee.find(params[:id])

    respond_to do |format|
      if @tioj_ojee.update_attributes(params[:tioj_ojee])
        format.html { redirect_to(oier_ojees_path(params[:oier_id]), :notice => 'OJ Account was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
  end

end
