class ApplicationController < ActionController::Base
  include Clerk::Authenticatable

  allow_browser versions: :modern
end
