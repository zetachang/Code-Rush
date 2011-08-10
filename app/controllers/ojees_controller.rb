class OjeesController < ApplicationController 
  before_filter :authenticate_user!
  before_filter :must_be_the_current_oier
  authorize_resource :instance_name => :ojee, :class => TiojOjee
  authorize_resource :instance_name => :ojee, :class => PkuOjee
  authorize_resource :instance_name => :ojee, :class => UvaOjee
  authorize_resource :instance_name => :ojee, :class => ZerojudgeOjee

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
      @ojee.oier = @oier
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
  
  def update_stats
    @oier = Oier.find_by_name(params[:oier_id])
    @ojee = Ojee.find_by_ojtype(params[:id])
    if @ojee.update_stats
      @ojee.save
      render :json => @ojee
    else
      render :json => "Syncronization Errors", :status => :unprocessable_entity
    end
  end
  
  protected
  
    def must_be_the_current_oier
      oier = Oier.find_by_name(params[:oier_id])
      if oier != current_oier
        redirect_to :root, :alert => 'Permission Denied'
      end
    end
end
