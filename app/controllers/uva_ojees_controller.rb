class UvaOjeesController < OjeesController
  def new
    @oier = Oier.find(params[:oier_id])
    @uva_ojee =UvaOjee.new
  end

  def edit
    @oier = Oier.find(params[:oier_id])
    @uva_ojee = UvaOjee.find(params[:id])
    #p 'XDDDD'
    #p current_user.oier.name
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

  def update
    @uva_ojee = UvaOjee.find(params[:id])
    @oier = Oier.find(params[:oier_id])
    respond_to do |format|
      if @uva_ojee.update_attributes(params[:uva_ojee])
        format.html { redirect_to(oier_ojees_path(params[:oier_id]), :notice => 'OJ Account was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @oier = Oier.find(params[:oier_id])
    @uva_ojee = UvaOjee.find(params[:id])
    @uva_ojee.destroy
    redirect_to oier_ojees_path(@oier)
  end

  def update_stat
    uva_ojee = UvaOjee.find(params[:id])
    if uva_ojee.update_stat
      uva_ojee.save
      redirect_to oier_ojees_path(params[:oier_id]), :notice => "Stats successfully updated!"
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