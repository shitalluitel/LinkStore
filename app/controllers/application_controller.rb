class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  layout :layout_by_resource

  protected

  def layout_by_resource
    if !user_signed_in?
      "home"
    else
      "dashboard"
    end
  end

end
