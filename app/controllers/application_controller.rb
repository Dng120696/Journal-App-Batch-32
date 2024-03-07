class ApplicationController < ActionController::Base
  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end
  protected
  def after_sign_out_path_for(resource_or_scope)
    # Redirect to the sign in page
    new_user_session_path
  end


end
