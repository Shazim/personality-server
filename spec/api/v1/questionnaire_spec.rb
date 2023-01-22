# frozen_string_literal: true

require('swagger_helper')
describe 'Questions' do
  let(:user) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.create({resource_owner_id: user.id}).token }
  let(:fake_token) { 'fake_token' }

  path '/api/v1/questions' do
    get 'Get All Questions' do
      tags 'Questionnaire'
      security [ bearerAuth: [] ]

      consumes 'application/json'
      produces 'application/json'
      
      response '200', 'List Found' do
        let(:Authorization) { "Bearer #{token}" }
        run_test!
      end

      response '401', 'Invalid request' do
        let(:Authorization) { "Bearer #{fake_token}" }
        run_test!
      end
    end
  end

  path '/api/v1/attempts' do
    post 'Attempt Questionnaire' do
      tags 'Questionnaire'
      security [ bearerAuth: [] ]
      
      consumes 'application/json'
      produces 'application/json'

      parameter name: :attempt,
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    answers: {
                      type: :array,
                      items: {
                        type: :object,
                        properties: {
                          question_id: { type: :integer },
                          answer_id: { type: :integer },
                          points: { type: :integer },
                          total_points: { type: :integer },
                        },
                      }
                    }
                  }
                }
      
      response '200', 'Attempted' do
        let(:Authorization) { "Bearer #{token}" }
        let(:attempt) { {answers: []} }
        run_test!
      end

      response '401', 'Invalid request' do
        let(:Authorization) { "Bearer #{fake_token}" }
        let(:attempt) { {answers: []} }
        run_test!
      end
    end
  end
end
