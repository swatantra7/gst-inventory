class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :valid_request


  private

  def valid_request
    if unpermitted_request
      redirect_to new_user_session_path
    end
  end

  def unpermitted_request
    puts controller_name
    controller_name ==  'registrations'
  end

end
