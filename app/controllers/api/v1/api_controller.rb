require 'api_error_handler'

module Api
  module V1
    class ApiController < ActionController::API
      before_action :doorkeeper_authorize!

      include Response
      include CustomException
      handle_api_errors(backtrace: true)

      def current_user
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
