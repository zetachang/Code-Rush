class TiojOjeesController < OjeesController
  
  def new
    @oier = Oier.find(params[:oier_id])
    @tioj_ojee = TiojOjee.new
  end

  def create
    @tioj_ojee = TiojOjee.new(params[:tioj_ojee])
    @oier = Oier.find(params[:oier_id])
    @tioj_ojee.oier = @oier
    if @tioj_ojee.save
      redirect_to( oier_ojees_path(@oier), :notice => 'Your account was successfully created.') 
    else
      render :action => "new"
    end
  end

end
