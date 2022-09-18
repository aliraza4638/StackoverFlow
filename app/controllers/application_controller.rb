class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def content_not_found
        raise ActionController::RoutingError.new('Not Found')
    end
      
end
