
class OjeesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  #before_filter :current_oier?, :except => [:index] 
  authorize_resource
  def index
    @ojee = Oier.find(params[:oier_id]).ojee
    @oier = Oier.find(params[:oier_id])
  end

  protected
    
    def current_oier?
      if not current_user.oier or current_user.oier != Oier.find(params[:oier_id])
        redirect_to oier_ojees_path(@oier), :alert => "Permission Denied!!"
      end
    end
end
