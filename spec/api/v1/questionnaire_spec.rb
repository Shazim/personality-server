# frozen_string_literal: true

require('swagger_helper')
describe 'Questions' do
  path '/api/v1/questions' do
    get 'Get All Questions' do
      tags 'Questionnaire'
      security [ bearerAuth: [] ]

      consumes 'application/json'
      produces 'application/json'
      
      response '200', 'List Found' do
        run_test!
      end

      response '422', 'Invalid request' do
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
                          answer_text: { type: :string },
                          points: { type: :integer },
                          total_points: { type: :integer },
                        },
                      }
                    }
                  }
                }
      
      response '200', 'Attempted' do
        run_test!
      end

      response '422', 'Invalid request' do
        run_test!
      end
    end
  end
end
