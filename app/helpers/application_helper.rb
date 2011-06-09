module ApplicationHelper
  def sign_tag
    if user_signed_in?
      return link_to "Sign Out", destroy_user_session_path
    else
      return link_to "Sign In", new_user_session_path
    end
  end

  def sign_up_or_edit
    if user_signed_in?
      return link_to "Edit Info", edit_user_registration_path
    else
      return link_to "Sign Up", new_user_registration_path
    end
  end

  def oier_logged_in?
    if user_signd_in?
      if current_user.oier && current_user.oier == @oier
        yield
      end
    end
  end
end
