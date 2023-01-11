module Api
  module V1
    class QuestionsController < ApiController
      skip_before_action :doorkeeper_authorize!
      
      def index
        @questions = Question.includes(:answers).all
      end
    end
  end
end
