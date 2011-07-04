module ApplicationHelper
  def menu_for(bar,&block)
    menu_items = ['Oier Rank', "Assignments", "Code Snippet"]
    path_of = { "Oier Rank" => oiers_path, 
                "Assignments" => assignments_path,
                "Code Snippet" => codes_path }
    menu_items.each do |item|
      if item == bar and block_given? 
        concat content_tag(:li,(link_to item, path_of[item]),:class => 'selected') 
        sub_menu = content_tag(:div,:id => 'sub_menu') do
          capture(&block)
        end
        concat sub_menu
      else
        concat content_tag(:li,(link_to item, path_of[item]))
      end
    end
  end
  
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
