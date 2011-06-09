class PkuOjeesController < OjeesController
  def new
    @oier = Oier.find(params[:oier_id])
    @pku_ojee = PkuOjee.new
  end

  def edit
    @oier = Oier.find(params[:oier_id])
    @pku_ojee = PkuOjee.find(params[:id])
  end

  def create
    @pku_ojee = PkuOjee.new(params[:pku_ojee])
    @oier = Oier.find(params[:oier_id])
    @pku_ojee.oier = @oier
    if @pku_ojee.save
      redirect_to( oier_ojees_path(@oier), :notice => 'Your account was successfully created.') 
    else
      render :action => "new"
    end
  end

  def update
    @pku_ojee = PkuOjee.find(params[:id])
    @oier = Oier.find(params[:oier_id])
    respond_to do |format|
      if @pku_ojee.update_attributes(params[:pku_ojee])
        format.html { redirect_to(oier_ojees_path(params[:oier_id]), :notice => 'OJ Account was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @oier = Oier.find(params[:oier_id])
    @pku_ojee = PkuOjee.find(params[:id])
    @pku_ojee.destroy
    redirect_to oier_ojees_path(@oier)
  end

  def update_stat
    pku_ojee = PkuOjee.find(params[:id])
    pku_ojee.update_stat
    pku_ojee.save
    redirect_to oier_ojees_path(params[:oier_id])
  end
end
