
class OjeesController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource
  
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
