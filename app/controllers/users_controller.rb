class UsersController <AdminController
  def destroy
    user = User.find(params[:id])
    if user != current_user
      user.destroy
    else
      flash.alert = "You can't delete your self!!"
    end
    redirect_to admin_path
  end
end