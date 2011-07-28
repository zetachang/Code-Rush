class PkuOjeesController < OjeesController
  def new
    @oier = Oier.find(params[:oier_id])
    @pku_ojee = PkuOjee.new
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


  def destroy
    @oier = Oier.find(params[:oier_id])
    @pku_ojee = PkuOjee.find(params[:id])
    @pku_ojee.destroy
    redirect_to oier_ojees_path(@oier)
  end

end
