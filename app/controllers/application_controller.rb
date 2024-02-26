class ApplicationController < ActionController::Base
  protected

  def after_sign_out_path_for(resource_or_scope)
    # Redirect to the sign in page
    new_user_session_path
  end
end
