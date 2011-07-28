class UvaOjeesController < OjeesController
  def new
    @oier = Oier.find(params[:oier_id])
    @uva_ojee =UvaOjee.new
  end

  def create
    @uva_ojee = UvaOjee.new(params[:uva_ojee])
    @oier = Oier.find(params[:oier_id])
    @uva_ojee.oier = @oier
    if @uva_ojee.save
      redirect_to( oier_ojees_path(@oier), :notice => 'Your account was successfully created.') 
    else
      render :action => "new"
    end
  end

  def destroy
    @oier = Oier.find(params[:oier_id])
    @uva_ojee = UvaOjee.find(params[:id])
    @uva_ojee.destroy
    redirect_to oier_ojees_path(@oier)
  end
end