# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def content_not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
