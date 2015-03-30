module ApplicationHelper

  def login_or_logout
   if logged_in?
     "#{link_to "Log Out", logout_path}".html_safe
   else
     "#{link_to "Log In", login_path} | #{link_to "Sign Up", signup_path}".html_safe

   end
 end


end
