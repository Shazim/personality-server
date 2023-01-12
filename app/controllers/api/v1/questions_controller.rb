module Api
  module V1
    class QuestionsController < ApiController      
      def index
        @questions = Question.includes(:answers).all
      end
    end
  end
end
