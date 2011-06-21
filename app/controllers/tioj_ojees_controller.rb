class TiojOjeesController < OjeesController
  
  def new
    @oier = Oier.find(params[:oier_id])
    @tioj_ojee = TiojOjee.new
  end

  def edit
    @oier = Oier.find(params[:oier_id])
    @tioj_ojee = TiojOjee.find(params[:id])
    authorize! :edit, @tioj_ojee
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

  def update
    @tioj_ojee = TiojOjee.find(params[:id])
    @oier = Oier.find(params[:oier_id])
    respond_to do |format|
      if @tioj_ojee.update_attributes(params[:tioj_ojee])
        format.html { redirect_to(oier_ojees_path(params[:oier_id]), :notice => 'OJ Account was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @oier = Oier.find(params[:oier_id])
    @tioj_ojee = TiojOjee.find(params[:id])
    @tioj_ojee.destroy
    redirect_to oier_ojees_path(@oier)
  end

  def update_stat
    tioj_ojee = TiojOjee.find(params[:id])
    if tioj_ojee.update_stat
      tioj_ojee.save
      redirect_to oier_ojees_path(params[:oier_id])
    else
      msg = <<-EOF
        The updating failed. The reasons may be:
        (1) Your account info provided may be wrong.
        (2) The server side parsing problems. Contact the admin.
      EOF
      redirect_to oier_ojees_path(params[:oier_id]), :alert => msg
    end
  end
  

end
