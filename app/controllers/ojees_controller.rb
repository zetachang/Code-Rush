class OjeesController < ApplicationController 
  before_filter :authenticate_user!
  authorize_resource
  
  def new
    @oier = Oier.find_by_name(params[:oier_id])
    ojtype = params[:ojtype]
    if Ojee::OJ_TYPES.include?(ojtype)      
      @ojee = Ojee::OJ_MAP[ojtype].constantize.new
    else
      redirect_to @oier, :alert => 'This OJ type is not supported.'
    end
  end

  def create
    @oier = Oier.find_by_name(params[:oier_id])
    if Ojee::TYPES.include?(params[:type])
      @ojee = params[:type].constantize.new(params[:ojee])
      # ojtype => type, so this step will find the ojtype of the corresponding type
      @ojee.ojtype = Ojee::OJ_MAP.find{|p| p.second == params[:type]}.first
    else
      redirect_to @oier, :alert => 'This OJ type is not supported.'
    end
    
    if @ojee.save
      @oier.ojees << @ojee
      redirect_to @oier, :notice => 'OJ Account successfully created.'
    else
      render :action => :new
    end
  end

  def edit
    @oier = Oier.find_by_name(params[:oier_id])
    @ojee = @oier.ojees.find_by_ojtype(params[:id])
  end
  
  def update
    @oier = Oier.find_by_name(params[:oier_id])
    @ojee = @oier.ojees.find_by_ojtype(params[:id])
    if @ojee.update_attributes(params[:ojee])
      redirect_to @oier, :notice => 'OJ Account was successfully updated.'
    else
      render :action => :edit
    end
  end
  
  def destroy
    @oier = Oier.find_by_name(params[:oier_id])
    @ojee = Ojee.find_by_ojtype(params[:id])
    @ojee.destroy
    redirect_to @oier
  end
  
  def update_stat 
    @oier = Oier.find_by_name(params[:oier_id])
    ojee = Ojee.find(params[:id])
    if ojee.update_stat
      ojee.save
      redirect_to @oier
    else
      msg = <<-EOF
        The updating failed. The reasons may be:
        (1) Your account info provided may be wrong.
        (2) The server side parsing problems. Contact the admin.
      EOF
      redirect_to @oier, :alert => msg
    end
  end
end
