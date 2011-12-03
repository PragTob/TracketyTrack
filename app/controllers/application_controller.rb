class ApplicationController < ActionController::Base
  include SessionsHelper
  include CurrentHelper

  protect_from_forgery
end

