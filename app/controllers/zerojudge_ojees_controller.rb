class ZerojudgeOjeesController < OjeesController
  def new
    @oier = Oier.find_by_name(params[:oier_id])
    @ojee = ZerojudgeOjee.new
    render :template => 'ojees/new'
  end

  def create
    @ojee = ZerojudgeOjee.new(params[:ojee])
    @oier = Oier.find_by_name(params[:oier_id])
    @ojee.oier = @oier
    if @ojee.save
      redirect_to  @oier, :notice => 'Your account was successfully created.' 
    else
      render :template => "ojees/new"
    end
  end

  def destroy
    @oier = Oier.find(params[:oier_id])
    @zerojudge_ojee = ZerojudgeOjee.find(params[:id])
    @zerojudge_ojee.destroy
    redirect_to oier_ojees_path(@oier)
  end
end