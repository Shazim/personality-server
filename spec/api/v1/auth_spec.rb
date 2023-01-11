# frozen_string_literal: true

require('swagger_helper')

describe 'Authentication' do
  path '/api/v1/users' do
    post 'Signup' do
      tags 'Authentication'
      security []
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user,
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    user: {
                      type: :object,
                      properties: {
                        email: { type: :string },
                        password: { type: :string },
                        password_confirmation: { type: :string },
                      },
                      required: %i[email password password_confirmation]
                    },
                  }
                }

      response '200', 'Sign up' do
        run_test!
      end

      response '422', 'Invalid request' do
        run_test!
      end
    end
  end

  path '/api/v1/oauth/token' do
    post 'Login' do
      tags 'Authentication'
      security []
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user,
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    email: { type: :string },
                    password: { type: :string },
                    grant_type: { type: :string, example: 'password' },
                  },
                  required: %i[email password grant_type]
                }

      response '200', 'Login' do
        let(:Authorization) { "Bearer #{generate_token}" }
        run_test!
      end

      response '422', 'Invalid request' do
        run_test!
      end
    end
  end
end
