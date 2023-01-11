# frozen_string_literal: true

require 'api_error_handler'

module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController

        include Response
        include CustomException
        handle_api_errors(backtrace: true)

        def create
          build_resource(sign_up_params)

          resource.save
          if resource.persisted?
            expire_data_after_sign_in! unless resource.active_for_authentication?
            json_response({ user: resource }, 200)
          else
            raise_error('Validation failed', resource.errors, 422)
          end
        end
      end
    end
  end
end
