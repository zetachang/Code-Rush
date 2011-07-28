
class OjeesController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource
   
  def edit
    @oier = Oier.find_by_name(params[:oier_id])
    @ojee = Ojee.find(params[:id])
    render :template => "ojees/edit"
  end
  
  def update
    @ojee = Ojee.find(params[:id])
    @oier = Oier.find_by_name(params[:oier_id])
    if @ojee.update_attributes(params[:ojee])
      redirect_to @oier, :notice => 'OJ Account was successfully updated.'
    else
      render :template => "ojees/edit"
    end
  end
  
  def destroy
    @oier = Oier.find_by_name(params[:oier_id])
    ojee = Ojee.find(params[:id])
    ojee.destroy
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
  
  protected
    
    def current_oier?
      if not current_user.oier or current_user.oier != Oier.find(params[:oier_id])
        redirect_to oier_ojees_path(@oier), :alert => "Permission Denied!!"
      end
    end
end
