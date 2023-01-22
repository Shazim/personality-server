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
        let(:user) {{user: {email: 'user1@example.com', password: 123456, password_confirmation: 123456}}}
        run_test!
      end

      response '422', 'Invalid request' do
        let(:user) { {user: {}}}
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
        let(:created_user) { create(:user) }
        let(:user) {{email: created_user.email, password: created_user.password, grant_type: 'password'}}
        run_test!
      end

      response '401', 'Invalid request' do
        let(:user) {{email: 'random@email.com', password: '123456', grant_type: 'password'}}
        run_test!
      end
    end
  end
end
