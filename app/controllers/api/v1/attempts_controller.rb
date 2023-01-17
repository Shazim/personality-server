module Api
  module V1
    class AttemptsController < ApiController      
      def create
        attempt = current_user.attempts.create!(attempt_params)
        
        json_response({ attempt: attempt, message: result_message(attempt.percentage) }, 200)
      end

      private

      def attempt_params
        {}.tap do |p|
          p[:answers] = params[:answers]
          p[:points] = params[:answers].sum { |h| h[:points] }
          p[:total_points] = params[:answers].sum { |h| h[:total_points] }
          p[:percentage] = p[:points].to_f / p[:total_points]  * 100
        end
      end

      def result_message(percentage)
        case percentage
        when 0..33 then 'You are an Introvert'
        when 34..66 then 'You are Normal'
        when 67..100 then 'You are an Extrovert'
        else 'Something wrong with your personality'
        end
      end
    end
  end
end
