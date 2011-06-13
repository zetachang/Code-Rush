class ZerojudgeOjeesController < OjeesController
  def new
    @oier = Oier.find(params[:oier_id])
    @zerojudge_ojee = ZerojudgeOjee.new
  end

  def edit
    @oier = Oier.find(params[:oier_id])
    @zerojudge_ojee = ZerojudgeOjee.find(params[:id])
  end

  def create
    @zerojudge_ojee = ZerojudgeOjee.new(params[:zerojudge_ojee])
    @oier = Oier.find(params[:oier_id])
    @zerojudge_ojee.oier = @oier
    if @zerojudge_ojee.save
      redirect_to( oier_ojees_path(@oier), :notice => 'Your account was successfully created.') 
    else
      render :action => "new"
    end
  end

  def update
    @zerojudge_ojee = ZerojudgeOjee.find(params[:id])
    @oier = Oier.find(params[:oier_id])
    respond_to do |format|
      if @zerojudge_ojee.update_attributes(params[:zerojudge_ojee])
        format.html { redirect_to(oier_ojees_path(params[:oier_id]), :notice => 'OJ Account was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @oier = Oier.find(params[:oier_id])
    @zerojudge_ojee = ZerojudgeOjee.find(params[:id])
    @zerojudge_ojee.destroy
    redirect_to oier_ojees_path(@oier)
  end

  def update_stat
    zerojudge_ojee = ZerojudgeOjee.find(params[:id])
    if zerojudge_ojee.update_stat
      zerojudge_ojee.save
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